#!/bin/bash
echo "--- Ħ HEALTHPAY: CREATING TREASURY VAULT ---"

# 1. Generate Distributor Keys
KEYS=$(node -e "const s = require('stellar-sdk'); const k = s.Keypair.random(); console.log(k.publicKey() + ' ' + k.secret())")
DIST_PUB=$(echo $KEYS | cut -d' ' -f1)
DIST_SEC=$(echo $KEYS | cut -d' ' -f2)

# 2. Get Issuer Keys from our file
ISSUER_PUB=$(grep "PUBLIC_KEY" active_keys.txt | cut -d'=' -f2)
ISSUER_SEC=$(grep "SECRET_KEY" active_keys.txt | cut -d'=' -f2)

echo "Funding Vault ($DIST_PUB)..."
curl -s "https://friendbot.stellar.org/?addr=$DIST_PUB" > /dev/null

# 3. Create the Trustline using Node
cat << 'NODE_EOF' > tmp_trust.js
const StellarSdk = require('stellar-sdk');
async function run() {
    const server = new StellarSdk.Horizon.Server('https://horizon-testnet.stellar.org');
    const distKeys = StellarSdk.Keypair.fromSecret(process.argv[2]);
    const issuerPub = process.argv[3];
    const asset = new StellarSdk.Asset('HealthCoin', issuerPub);
    
    const account = await server.loadAccount(distKeys.publicKey());
    const tx = new StellarSdk.TransactionBuilder(account, { 
        fee: await server.fetchBaseFee(),
        networkPassphrase: StellarSdk.Networks.TESTNET 
    })
    .addOperation(StellarSdk.Operation.changeTrust({ asset: asset }))
    .setTimeout(30).build();
    
    tx.sign(distKeys);
    await server.submitTransaction(tx);
    console.log("TRUST_SUCCESS");
}
run();
NODE_EOF

node tmp_trust.js "$DIST_SEC" "$ISSUER_PUB"

if [ $? -eq 0 ]; then
    echo "--------------------------------------------"
    echo "VAULT_PUB=$DIST_PUB" >> active_keys.txt
    echo "VAULT_SEC=$DIST_SEC" >> active_keys.txt
    echo "✅ VAULT READY: Trustline Established."
else
    echo "❌ Failed to set trustline."
fi
rm tmp_trust.js
