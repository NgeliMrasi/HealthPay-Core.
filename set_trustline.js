const StellarSdk = require('stellar-sdk');
const fs = require('fs');

const server = new StellarSdk.Horizon.Server('https://horizon-testnet.stellar.org');

// Read our active keys
const keysFile = fs.readFileSync('active_keys.txt', 'utf8');
const SEC = keysFile.match(/SECRET_KEY=(.*)/)[1];
const PUB = keysFile.match(/PUBLIC_KEY=(.*)/)[1];

async function setTrust() {
    try {
        const sourceKeys = StellarSdk.Keypair.fromSecret(SEC);
        const asset = new StellarSdk.Asset('HealthCoin', PUB);

        console.log("Setting Trustline for HealthCoin...");
        const account = await server.loadAccount(PUB);
        
        const transaction = new StellarSdk.TransactionBuilder(account, { 
            fee: await server.fetchBaseFee(),
            networkPassphrase: StellarSdk.Networks.TESTNET 
        })
            .addOperation(StellarSdk.Operation.changeTrust({
                asset: asset,
                limit: '100000000'
            }))
            .setTimeout(30)
            .build();

        transaction.sign(sourceKeys);
        const result = await server.submitTransaction(transaction);
        console.log('✅ Trustline Established! Hash:', result.hash);
    } catch (e) {
        console.error('❌ Trustline Failed:', e.response ? e.response.data.extras.result_codes : e);
    }
}
setTrust();
