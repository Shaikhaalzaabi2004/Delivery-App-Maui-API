# DeliveryApi

This is an ASP.NET API for the DeliveryApp project.

## Prerequisites

- [.NET SDK](https://dotnet.microsoft.com/download)
- [SQL Server](https://www.microsoft.com/en-us/sql-server/sql-server-downloads)

## Setup Instructions

1. **Clone the repository**
    ```bash
    git clone <repository-url>
    cd DeliveryApi
    ```

2. **Restore dependencies**
    ```bash
    dotnet restore
    ```

3. **Configure the database**
    - Locate the database script (`database.sql`) in the root folder.
    - Run the script in your SQL Server instance to create the required database and tables.

4. **Update connection string**
    - Open `appsettings.json`.
    - Set your SQL Server connection string under `ConnectionStrings:DefaultConnection`.

5. **Run the API**
    ```bash
    dotnet run
    ```

6. **Access the API**
    - The API will be available at `https://localhost:5001` or `http://localhost:5000`.

## Troubleshooting

- Ensure SQL Server is running and accessible.
- Check firewall settings if you cannot connect to the database.

## License

This project is licensed under the MIT License.

## Important Note

After creating the database, update the `DeliveryDatabaseContext.cs` file located in the `Models` folder with your current SQL Server user credentials to ensure proper database connectivity.