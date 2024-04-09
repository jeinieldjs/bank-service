class Bank
    def initialize
        @accounts = []
    end

    def create_account(name,account_number, balance = 0)
        if @accounts.find { |account| account[:account_number] == account_number }
          p "Account number #{account_number} is already taken."
          return
        end

        account = { name: name, account_number: account_number, balance: balance }
        @accounts << account
        account
    end

    def deposit(account_number, amount)
        account = @accounts.find { |account| account[:account_number] == account_number }

        if !account
            p "Account #{account_number} does not exist."
            return
        end

        if amount <= 0
            p "Invalid amount."
            return
        else
            account[:balance] += amount
            p "Successfully deposited #{amount} to account #{account_number}."
        end
    end

    def withdraw(account_number, amount)
        account = @accounts.find { |account| account[:account_number] == account_number }

        if !account
            p "Account #{account_number} does not exist."
            return
        end

        if amount <= 0
            p "Invalid amount."
            return
        elsif amount > account[:balance]
            p "Insufficient funds."
            return
        else
            account[:balance] -= amount
            p "Successfully withdrawn #{amount} from account #{account_number}."
        end
    end

    def transfer(sender_acct, receiver_acct, amount)
        sender = @accounts.find { |account| account[:account_number] == sender_acct }
        receiver = @accounts.find { |account| account[:account_number] == receiver_acct }
        
        if !sender || !receiver
            p "Transaction cannout proceed since one or both of the accounts do not exist."
            return
        end

        if amount <= 0
            p "Invalid amount."
            return
        elsif amount > sender[:balance]
            p "Sender has insufficient funds for this transaction."
            return
        else
            sender[:balance] -= amount
            receiver[:balance] += amount
            p "Successfully transferred #{amount} from #{sender_acct} to #{receiver_acct}."
        end
    end

    def get_balance(account_number)
        account = @accounts.find { |account| account[:account_number] == account_number}

        if account 
            return "#{account[:name]}'s balance is #{account[:balance]}"
        else
            return "Account #{account_number} does not exist."
        end
    end

    def accounts
        @accounts
    end


end

# test
bank = Bank.new
# valid user
user1 = bank.create_account("John Doe", 12345678, 5000)
p user1
# taken account number
bank.create_account("Jane Doe", 12345678, 7000)
# deposit (valid acct)
bank.deposit(12345678, 200)
# deposit (invalid acct)
bank.deposit(12345673, 200)
# deposit (invalid amount)
bank.deposit(12345678, 0)
# withdraw (valid transaction / with enough funds)
bank.withdraw(12345678, 500)
# withdraw (not enough funds)
bank.withdraw(12345678, 10000)
# transfer (no receiver)
bank.transfer(12345678, 01234567, 900)
user2 = bank.create_account("Jose Reyes", 23456789, 100)
# transfer (invalid amount)
bank.transfer(12345678, 23456789, 0)
bank.transfer(12345678, 23456789, 10000)
# transfer (valid)
bank.transfer(12345678, 23456789, 10)
# balance (no account)
p bank.get_balance(3456)
# balance (existing account)
p bank.get_balance(12345678)
# get all accounts
p bank.accounts

