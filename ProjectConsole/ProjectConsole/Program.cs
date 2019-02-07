using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;

namespace ProjectConsole
{
    class Program
    {
        static void Main(string[] args)
        {
            string s = "";
            if (args.Length != 0) s = args[0];
            BuShi bushi = new BuShi();
            var bengua = bushi.ChengGua(s);
            Console.WriteLine(bushi.GetInfo());
            Console.WriteLine("本卦"+bengua.GuaCi.Name);
            Console.WriteLine(bengua.GuaXiangFuhao());
            Console.WriteLine("变卦"+bengua.BianGua().GuaCi.Name);
            Console.WriteLine(bengua.BianGua().GuaXiangFuhao());
            Console.WriteLine(bengua.Yaoci());
        }    
    }
}
