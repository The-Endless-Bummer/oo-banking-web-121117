class Transfer
  attr_reader :sender, :receiver, :amount
  attr_accessor :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = 'pending'
    @amount = amount
  end

  def valid?
    if self.sender.valid? && self.receiver.valid?
      true
    else
      false
    end
  end

  def execute_transaction
    if self.valid? && self.status == 'pending' && self.sender.balance > self.amount
      self.sender.withdraw(self.amount)
      self.receiver.deposit(self.amount)
      self.status = 'complete'
    else
      self.status = 'rejected'
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if status == 'complete'
      self.sender.deposit(self.amount)
      self.receiver.withdraw(self.amount)
      self.status = 'reversed'
    end
  end
end
