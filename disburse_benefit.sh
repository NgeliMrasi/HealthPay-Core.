#!/bin/bash
# Ħ HEALTHPAY: Employee Benefit Allocation (R499 Tier Logic)

VAULT_SEC=$(grep "VAULT_SEC" active_keys.txt | cut -d'=' -f2)
ISSUER_PUB=$(grep "PUBLIC_KEY" active_keys.txt | cut -d'=' -f2)

echo "--- Ħ HEALTHPAY: ALLOCATING EMPLOYEE BENEFITS ---"

# 1. Generate Worker Wallet
echo "[1/3] Creating Worker Wallet..."
WORKER_KEYS=$(node -e "const s = require('stellar-sdk'); const k = s.Keypair.random(); console.log(k.publicKey() + ' ' + k.secret())")
WORKER_PUB=$(echo $WORKER_KEYS | cut -d' ' -f1)
WORKER_SEC=$(echo $WORKER_KEYS | cut -d' ' -f2)

# 2. Fund Worker
curl -s "https://friendbot.stellar.org/?addr=$WORKER_PUB" > /dev/null

# 3. Process Transaction
cat << 'NODE_EOF' > tmp_benefit.js
const StellarSdk = require('stellar-sdk');
async function run() {
    const server = new StellarSdk.Horizon.Server('https://horizon-testnet.stellar.org');
    const vaultKeys = StellarSdk.Keypair.fromSecret(process.argv[2]);
    const workerKeys = StellarSdk.Keypair.fromSecret(process.argv[3]);
    const issuerPub = process.argv[4];
    const asset = new StellarSdk.Asset('HealthCoin', issuerPub);

    // Set Trust
    const workerAcc = await server.loadAccount(workerKeys.publicKey());
    const trustTx = new StellarSdk.TransactionBuilder(workerAcc, { 
        fee: await server.fetchBaseFee(),
        networkPassphrase: StellarSdk.Networks.TESTNET 
    }).addOperation(StellarSdk.Operation.changeTrust({ asset: asset })).setTimeout(30).build();
    trustTx.sign(workerKeys);
    await server.submitTransaction(trustTx);

    // Move HealthCoin
    const vaultAcc = await server.loadAccount(vaultKeys.publicKey());
    const payTx = new StellarSdk.TransactionBuilder(vaultAcc, { 
        fee: await server.fetchBaseFee(),
        networkPassphrase: StellarSdk.Networks.TESTNET 
    }).addOperation(StellarSdk.Operation.payment({
        destination: workerKeys.publicKey(),
        asset: asset,
        amount: '50.00' // Example allocation per check-up/benefit
    })).setTimeout(30).build();
    payTx.sign(vaultKeys);
    const res = await server.submitTransaction(payTx);
    console.log(res.hash);
}
run();
NODE_EOF

echo "[2/3] Syncing HealthCoin to Employee..."
TX_HASH=$(node tmp_benefit.js "$VAULT_SEC" "$WORKER_SEC" "$ISSUER_PUB")

if [ $? -eq 0 ]; then
    echo "------------------------------------------"
    echo "✅ BENEFIT ALLOCATED"
    echo "Worker: $WORKER_PUB"
    echo "TX: $TX_HASH"
    echo "------------------------------------------"
else
    echo "❌ Allocation failed."
fi
rm tmp_benefit.js
