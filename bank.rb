class Bank
    def initialize
        @accounts = []
    end

    def create_account(name, account_number, balance = 0)
        if @accounts.find { |account| account[:account_number] == account_number }
          puts "Account number #{account_number} is already taken."
          return
        end

        if !(account_number.is_a?(Integer) && account_number.to_s.length == 8)
            puts "Account number must be an 8-digit integer."
            return
        end

        if balance < 0
            puts "Initial balance cannot be negative."
            return
        end

        account = { name: name, account_number: account_number, balance: balance }
        @accounts << account
        puts "Account is created successfully."
        account
    end

    def deposit(account_number, amount)
        account = @accounts.find { |account| account[:account_number] == account_number }

        if !account
            puts "Account #{account_number} does not exist."
            return
        end

        if amount <= 0
            puts "Invalid amount."
            return
        else
            account[:balance] += amount
            puts "Successfully deposited #{amount} to account #{account_number}."
        end
    end

    def withdraw(account_number, amount)
        account = @accounts.find { |account| account[:account_number] == account_number }

        if !account
            puts "Account #{account_number} does not exist."
            return
        end

        if amount <= 0
            puts "Invalid amount."
            return
        elsif amount > account[:balance]
            puts "Insufficient funds."
            return
        else
            account[:balance] -= amount
            puts "Successfully withdrawn #{amount} from account #{account_number}."
        end
    end

    def transfer(sender_acct, receiver_acct, amount)
        sender = @accounts.find { |account| account[:account_number] == sender_acct }
        receiver = @accounts.find { |account| account[:account_number] == receiver_acct }
        
        if !sender || !receiver
            puts "Transaction cannout proceed since one or both of the accounts do not exist."
            return
        end

        if amount <= 0
            puts "Invalid amount."
            return
        elsif amount > sender[:balance]
            puts "Sender has insufficient funds for this transaction."
            return
        else
            sender[:balance] -= amount
            receiver[:balance] += amount
            puts "Successfully transferred #{amount} from #{sender_acct} to #{receiver_acct}."
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

# tests
bank = Bank.new
# valid user
puts user1 = bank.create_account("John Doe", 12345678, 5000)
# taken account number
bank.create_account("Jane Doe", 12345678, 7000)
# negative initial balance
bank.create_account("Jane Doe", 23456789, -900)
# wrong format of acct number
bank.create_account("Jane Doe", 2345, 36)
bank.create_account("Jane Doe", "password", 36)
# deposit (valid acct)
bank.deposit(12345678, 200)
puts bank.get_balance(12345678)
# deposit (invalid acct)
bank.deposit(12345673, 200)
# deposit (invalid amount)
bank.deposit(12345678, 0)
# withdraw (valid transaction / with enough funds)
bank.withdraw(12345678, 500)
puts bank.get_balance(12345678)
# withdraw (not enough funds)
bank.withdraw(12345678, 10000)
# transfer (no receiver)
bank.transfer(12345678, 01234567, 900)
puts user2 = bank.create_account("Jose Reyes", 23456789, 100)
# transfer (invalid amount)
bank.transfer(12345678, 23456789, 0)
bank.transfer(12345678, 23456789, 10000)
# transfer (valid)
bank.transfer(12345678, 23456789, 10)
# balance (no account)
puts bank.get_balance(3456)
# balance (existing account)
puts bank.get_balance(12345678)
# get all accounts
p bank.accounts


