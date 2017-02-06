defmodule BankAccountGSHideImpl do

  ## API

  def start(balance) do
    {:ok, account} = GenServer.start(__MODULE__, balance)
    account
  end

  def deposit(account, amount) do
    GenServer.cast(account, {:deposit, amount})
  end

  def withdraw(account, amount) do
    GenServer.cast(account, {:withdraw, amount})
  end

  def balance(account) do
    GenServer.call(account, :balance)
  end

  ## GenServer callbacks

  def init(balance) do
    {:ok, balance}
  end

  def handle_cast({:deposit, amount}, balance) do
    {:noreply, balance + amount}
  end

  def handle_cast({:withdraw, amount}, balance) do
    {:noreply, balance - amount}
  end

  def handle_call(:balance, _from, balance) do
    {:reply, balance, balance}
  end
end
