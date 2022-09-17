defmodule SageWeb.Admin.AccountsAdmin do
  alias Sage.Accounts

  def widgets(_schema, _conn) do
    [
      %{
        type: "tidbit",
        title: "Number of Users",
        content: Accounts.count_users(),
        icon: "user",
        order: 1,
        width: 6
      },
      %{
        type: "progress",
        title: "Pancakes",
        content: "Customer Satisfaction",
        percentage: 89,
        order: 3,
        width: 6
      },
      %{
        type: "chart",
        title: "This week's sales",
        order: 8,
        width: 12,
        content: %{
          x: ["Mon", "Tue", "Wed", "Thu", "Today"],
          y: [150, 230, 75, 240, 290],
          y_title: "USD"
        }
      }
    ]
  end
end
