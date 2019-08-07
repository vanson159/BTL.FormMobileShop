using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;

namespace BTL.MobileShop.Data
{
    public class DataAccess : IDisposable
    {
        #region Khai báo các đối tượng
        protected SqlConnection _sqlConnection;
        protected SqlCommand _sqlCommand;
        protected string _connectionString;

        public SqlCommand SqlCommand
        {
            get { return _sqlCommand; }
        }

        public SqlConnection SqlConnection
        {
            get { return _sqlConnection; }
        }
        #endregion

        #region Khai báo constructor
        public DataAccess()
        {
            // Khởi tạo connection
            _connectionString = @"Data Source=DESKTOP-7V8H1NS;Initial Catalog=MobilePhoneShop;User ID=sa;Password=son1591998";
            _sqlConnection = new SqlConnection(_connectionString);

            // Khởi tạo conmmand
            _sqlCommand = _sqlConnection.CreateCommand();
            _sqlCommand.CommandType = CommandType.StoredProcedure;

            // Mở kết nối 
            _sqlConnection.Open();
        }
        #endregion
        #region Các hàm thực thi ADO
        /// <summary>
        ///  Đọc bản ghi ra DataReader
        /// </summary>
        /// <param name="commandText">Tên store procedure</param>
        /// <returns>Tập hợp các bản ghi</returns>
        public SqlDataReader ExecuteReader(string commandText)
        {
            _sqlCommand.CommandText = commandText;
            return _sqlCommand.ExecuteReader();
        }
        /// <summary>
        ///  Hàm thực thi ExcuteNonQuery của SqlCommand
        /// </summary>
        /// <param name="commandText"></param>
        /// <returns>Trả về số bản ghi bị ảnh hưởng</returns>
        public int ExecuteNonQuery(string commandText)
        {
            _sqlCommand.CommandText = commandText;
            return _sqlCommand.ExecuteNonQuery();
        }
        /// <summary>
        /// Thực thi sqlCommand thông qua SqlAdapter sau đó đổ vào DataSet
        /// </summary>
        /// <param name="sqlCommand"></param>
        /// <returns></returns>
        public DataSet ExecuteSqlAdapter(SqlCommand sqlCommand)
        {
            SqlDataAdapter sqlDataAdapter = new SqlDataAdapter();
            sqlDataAdapter.SelectCommand = sqlCommand;
            DataSet dataSet = new DataSet();
            sqlDataAdapter.Fill(dataSet);
            return dataSet;
        }
        /// <summary>
        /// Hàm đóng connection
        /// </summary>
        public void Dispose()
        {
            _sqlConnection.Close();
        }
        #endregion

    }
}