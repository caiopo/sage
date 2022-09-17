defmodule SageWeb.Admin.Config do
  def create_resources(_conn) do
    [
      accounts: [
        name: "Users",
        resources: [
          users: [schema: Sage.Accounts.User, admin: SageWeb.Admin.AccountsAdmin]
          # comment: [schema: MyApp.Blog.Comment],
          # tag: [schema: MyApp.Blog.Tag]
        ]
      ]
      # inventory: [
      #   name: "Inventory",
      #   resources: [
      #     category: [schema: MyApp.Products.Category, admin: MyApp.Products.CategoryAdmin],
      #     product: [schema: MyApp.Products.Product, admin: MyApp.Products.ProductAdmin]
      #   ]
      # ]
    ]
  end
end
