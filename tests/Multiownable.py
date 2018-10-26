## NOTE: To run this test you should have geth >= 1.7.3
## NOTE: String to run geth right is: geth --dev --rpc --rpccorsdomain "http://localhost:8545" --rpcapi="db,eth,net,web3,personal,web3" --targetgaslimit '9000000'

import unittest
import time

from web3 import HTTPProvider
from contract import Contract, W3

w3 = W3(HTTPProvider('http://localhost:8545'), 6, 100000000000).instance()

timeout = 3
value = 400

owners = [w3.eth.accounts[1], w3.eth.accounts[2], w3.eth.accounts[3], w3.eth.accounts[4]]

simple_storage = Contract("SimpleStorage", w3, {"owner": owners[0], "args": [timeout, value]})
simple_storage.instance.transferOwnership(owners, transact={'from': owners[0]})

class Multiownable(unittest.TestCase):

    def test_set(self):
        value = 333

        simple_storage.instance.set(value, transact={'from': owners[0]})
        self.assertEqual(value, simple_storage.instance.get())


    def test_set_by_voters(self):
        value = 777

        for owner in owners:
            simple_storage.instance.setByVoters(value, transact={'from': owner})
        
        self.assertEqual(value, simple_storage.instance.get())

    
    def test_set_with_timeout(self):
        value = 666

        last_owner = owners[0]
        owners.remove(last_owner)

        for owner in owners:
            simple_storage.instance.setByVotersWithTimeout(value, transact={'from': owner})

        owners.append(last_owner)

        self.assertNotEqual(value, simple_storage.instance.get())

        simple_storage.instance.setByVotersWithTimeout(value, transact={'from': last_owner})
        self.assertEqual(value, simple_storage.instance.get())


    def test_set_with_timeout_expired(self):
        value = 555

        last_owner = owners[0]
        owners.remove(last_owner)

        for owner in owners:
            simple_storage.instance.setByVotersWithTimeout(value, transact={'from': owner})

        owners.append(last_owner)

        self.assertNotEqual(value, simple_storage.instance.get())

        time.sleep(simple_storage.instance.timeout() + 1)
        simple_storage.instance.setByVotersWithTimeout(value, transact={'from': last_owner})

        self.assertNotEqual(value, simple_storage.instance.get())


if __name__ == '__main__':
    unittest.main()
