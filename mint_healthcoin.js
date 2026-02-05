const StellarSdk = require('stellar-sdk');
const fs = require('fs');

const server = new StellarSdk.Horizon.Server('https://horizon-testnet.stellar.org');
const data = fs.readFileSync('active_keys.txt', 'utf8');

const ISSUER_SEC = data.match(/SECRET_KEY=(.*)/)[1];
const ISSUER_PUB = data.match(/PUBLIC_KEY=(.*)/)[1];
const VAULT_PUB = data.match(/VAULT_PUB=(.*)/)[1];

async function mint() {
    try {
        const issuerKeys = StellarSdk.Keypair.fromSecret(ISSUER_SEC);
        const asset = new StellarSdk.Asset('HealthCoin', ISSUER_PUB);

        console.log(`Minting 1,000,000 Ħ from Issuer to Vault...`);
        const account = await server.loadAccount(ISSUER_PUB);
        
        const transaction = new StellarSdk.TransactionBuilder(account, { 
            fee: await server.fetchBaseFee(),
            networkPassphrase: StellarSdk.Networks.TESTNET 
        })
            .addOperation(StellarSdk.Operation.payment({
                destination: VAULT_PUB,
                asset: asset,
                amount: '1000000'
            }))
            .setTimeout(30).build();

        transaction.sign(issuerKeys);
        const result = await server.submitTransaction(transaction);
        console.log('💰 MISSION ACCOMPLISHED! 1,000,000 Ħ is in the Vault.');
        console.log('Tx Hash:', result.hash);
    } catch (e) {
        console.error('❌ Minting Failed:', e.response ? e.response.data.extras.result_codes : e);
    }
}
mint();
