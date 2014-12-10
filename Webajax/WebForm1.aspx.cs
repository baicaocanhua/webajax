using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Webajax
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
        [WebMethod]
        public static string SayHello()
        {
            return "{\"aa\":\"11\"}";
        }

        [WebMethod]
        public static List<string> GetList()
        {
            return new List<string>() { "Frozen_Zhang", "Varchar32" };
        }

        [WebMethod]
        public static List<Dictionary<string, string>> GetlistDic()
        {
            List<Dictionary<string, string>> list = new List<Dictionary<string, string>>();
            Dictionary<string, string> dic = new Dictionary<string, string>();
            dic.Add("aa", "b");
            dic.Add("bb", "a");
            list.Add(dic);
            Dictionary<string, string> dic2 = new Dictionary<string, string>();
            dic2.Add("aaa", "b");
            dic2.Add("bbb", "a");
            list.Add(dic2);
            return list;

        }
        [WebMethod]
        public static Dictionary<string, string> GetDic()
        {
            Dictionary<string, string> dic = new Dictionary<string, string>();
            dic.Add("aa", "b");
            dic.Add("bb", "a");
            return dic;
        }


        [WebMethod]
        public static Person GetPerson()
        {
            return new Person()
            {
                Name = "Varchar32",
                Gender = true
            };
        }

        [WebMethod]
        public static List<Person> GetlistPerson()
        {
            return new List<Person>(){
                new Person() { 
                    Name = "Varchar32",
                    Gender = true
                },
                new Person(){
                    Name = "Frozen_Zhang",
                    Gender = true
                }
            };
        }


        [WebMethod]
        public static DataSet getDataSet()
        {
            var ds = new DataSet();
            var dt = new DataTable();
            dt.Columns.Add("Name");
            dt.Columns.Add("Gender");
            dt.Rows.Add("Varchar32", true);
            dt.Rows.Add("Frozen_Zhang", true);
            ds.Tables.Add(dt);
            return ds;
            //此处采用xml格式调用
            //$.ajax({
            //       url: "/CommonService.asmx/HelloWorld",
            //       type: "Post",
            //       dataType: "xml",
            //       data: {},
            //       success: function (data) {
            //           var str = "";
            //           $.each($.find("Table1", data), function () {
            //               str += $(this).find("Name").text() + (Boolean($(this).find("Gender").text()) ? "男" : "女") + ";";
            //           });

            //           str = str.substring(0, str.length - 1);
            //           $(".ajaxresult div:eq(1)").html("内容为：" + str);
            //       }
            //   });
        }


    }
    public class Person
    {
        public string Name { get; set; }
        public bool Gender { get; set; }
    }
}