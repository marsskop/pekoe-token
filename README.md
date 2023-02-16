# PekoeToken repo
Independent repo with Pekoe Tokens for PekoeTips service.

### Specs
- Solidity, ERC20 token
- Brownie x Hardhat network
- Alchemy x Goerli testnet

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