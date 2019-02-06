using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProjectConsole
{
    class BookParser
    {
        public static void YiBookTxt2Xml()
        {
            using (StreamReader sr = new StreamReader("yi.txt"))
            {
                using (StreamWriter sw = new StreamWriter("yi.xml"))
                {
                    sw.WriteLine("<?xml version=\"1.0\" encoding=\"utf-8\" ?> ");
                    sw.WriteLine("<ZhouYi>");
                    string line = "";
                    while ((line = sr.ReadLine()) != null)
                    {
                        if (line.StartsWith("第"))
                        {
                            sw.Write("<Gua ");
                            var ls = line.Split(' ');
                            var xiangName = ls[2];
                            sw.Write("name=\"{0}\"", xiangName);
                            sw.WriteLine(">");

                            sw.Write("<Ming>");
                            sw.WriteLine(line);
                            sw.WriteLine("</Ming>");

                            line = sr.ReadLine();
                            sw.Write("<Ben>");
                            sw.WriteLine(line);
                            sw.WriteLine("</Ben>");

                            line = sr.ReadLine();
                            sw.Write("<Tuan>");
                            sw.WriteLine(line);
                            sw.WriteLine("</Tuan>");

                            line = sr.ReadLine();
                            sw.Write("<Xiang>");
                            sw.WriteLine(line);
                            sw.WriteLine("</Xiang>");

                            line = sr.ReadLine();
                            sw.Write("<Chu>");
                            sw.WriteLine(line);
                            sw.WriteLine("</Chu>");

                            line = sr.ReadLine();
                            sw.Write("<Er>");
                            sw.WriteLine(line);
                            sw.WriteLine("</Er>");

                            line = sr.ReadLine();
                            sw.Write("<San>");
                            sw.WriteLine(line);
                            sw.WriteLine("</San>");

                            line = sr.ReadLine();
                            sw.Write("<Si>");
                            sw.WriteLine(line);
                            sw.WriteLine("</Si>");

                            line = sr.ReadLine();
                            sw.Write("<Wu>");
                            sw.WriteLine(line);
                            sw.WriteLine("</Wu>");

                            line = sr.ReadLine();
                            sw.Write("<Shang>");
                            sw.WriteLine(line);
                            sw.WriteLine("</Shang>");

                            line = sr.ReadLine();
                            if (line != null && line.StartsWith("用"))
                            {
                                sw.Write("<Yong>");
                                sw.WriteLine(line);
                                sw.WriteLine("</Yong>");

                                line = sr.ReadLine();
                                sw.Write("<Wenyan>");
                                sw.WriteLine(line);
                                sw.WriteLine("</Wenyan>");
                            }

                            sw.WriteLine("</Gua>");
                        }
                    }
                    sw.WriteLine("</ZhouYi>");
                }
            }
        }
    }
}
