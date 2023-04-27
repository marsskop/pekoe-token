# PekoeToken repo
⚠️ **WIP**

Independent repo with Pekoe Tokens for 🌿**PEKOE**🌿 tips service.

### Specs
- Solidity, ERC20 token
- Brownie x Hardhat network
- Infura x Sepolia (https://sepolia.dev/)

### Development Guide
Brownie: https://eth-brownie.readthedocs.io/en/stable/

#### Brownie x Hardhat installation
```
cd pekoe
python3 -m pip install pipx
python3 -m pipx ensurepath
python3 -m pipx install eth-brownie
npm install --save-dev hardhat
```
#### Brownie cheatsheet
```
brownie pm install OpenZeppelin/openzeppelin-contracts@4.8.1
brownie pm list
brownie compile
```
#### Brownie x Hardhat console cheatsheet
```
brownie console --network hardhat
```
Commands:
- interacting with accounts
```
accounts
accounts[0]
dir(accounts[0])  # available actions, e.g. accounts[0].balance() or accounts[0].transfer(accounts[1], "10 ether")
accounts.add()
# multiple transactions (without waiting for transaction completion)
transactions = [
    accounts[0].transfer(accounts[i], "1 ether", required_confs=0, silent=True) for i in range(1, 4)
]
[tx.status for tx in transactions]
```
- interacting with contracts
```
Pekoe.deploy(1e23, {'from': accounts[1]})
Pekoe
# callable methods in Solidity are view or pure
dir(Pekoe[0])
```
- interacting with blockchain
```
chain
web3.eth.blockNumber # height of chain
chain[-1] == web3.eth.get_block('latest')
# history
history
history.filter(sender=accounts[0], value="1 ether")
# mining
chain.mine(5)
web3.eth.blockNumber
# time travel
chain.time()
chain.sleep(1000)
chain.time()
# snapshots
chain.snapshot()
chain.revert()
chain.reset()  # genesis state
# undo/redo
chain.undo()
chain.redo()
```
- inspecting transactions
```
tx = Pekoe[0].transfer(accounts[1], 1e18, {'from': accounts[0]})
tx.info()
tx.events
tx.internal_transfers
```
- working with networks
```
brownie networks list
```

### Deploy to Infura x Sepolia
- set WEB3_INFURA_PROJECT_ID env variable with API key from Infura project
- add Sepolia network
```
brownie networks list
brownie networks add Ethereum sepolia host="https://rpc.sepolia.org/" chainid=11155111
```
- connect
```
brownie console --network sepolia
```
```
network.show_active()
network.is_connected()
```
- let's create a deployment account. check is there are any local accounts:
```
brownie accounts list
```
and create
```
brownie accounts generate deployment_account
```
- use https://sepoliafaucet.com/ to request ETH to pay gas; enter deployment-account address
- and check balance
```
brownie console --network sepolia
account = accounts.load('deployment_account')
web3.fromWei(account.balance(), 'ether')
```
- finally, deploy contract
```
brownie run deploy.py --network sepolia
```
- check out deployed contract on https://sepolia.etherscan.io/ using contract address