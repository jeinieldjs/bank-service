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


