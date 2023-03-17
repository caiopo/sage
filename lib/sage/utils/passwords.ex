defmodule Sage.Passwords do
  def hash(password) do
    Bcrypt.hash_pwd_salt(password)
  end
end
