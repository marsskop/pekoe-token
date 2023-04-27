from brownie import Pekoe, accounts

def main():
    account = accounts.load('deployment_account')
    Pekoe.deploy(1e23, {'from': account})
