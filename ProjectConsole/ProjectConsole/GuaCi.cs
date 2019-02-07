using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;

namespace ProjectConsole
{
    class GuaCi
    {
        public string Name { get; private set; }
        public string Ming { get; private set; }
        public string Ben { get; private set; }
        public string Tuan { get; private set; }
        public string Xiang { get; private set; }
        public string[] Yao { get; private set; }
        public string Yong { get; private set; }
        public string Wenyan { get; private set; }

        public GuaCi(XmlElement el)
        {
            Name = el.GetAttribute("name");
            Ming = el["Ming"].InnerText;
            Ben = el["Ben"].InnerText;
            Tuan = el["Tuan"].InnerText;
            Xiang = el["Xiang"].InnerText;
            Yao = new string[6];
            Yao[0] = el["Chu"].InnerText;
            Yao[1] = el["Er"].InnerText;
            Yao[2] = el["San"].InnerText;
            Yao[3]= el["Si"].InnerText;
            Yao[4] = el["Wu"].InnerText;
            Yao[5] = el["Shang"].InnerText;
            Yong = el["Yong"] == null ? null : el["Yong"].InnerText;
            Wenyan = el["Wenyan"] == null ? null : el["Wenyan"].InnerText;
        }

        public override string ToString()
        {
            StringBuilder sb = new StringBuilder();
            sb.AppendLine(Ming);
            sb.AppendLine(Ben);
            sb.AppendLine(Tuan);
            sb.AppendLine(Xiang);
            for (int i = 0; i < 6; i++)
                sb.AppendLine(Yao[i]);
            if (Yong != null) sb.AppendLine(Yong);
            if (Wenyan != null) sb.AppendLine(Wenyan);
            return sb.ToString();
        }
        public string ToShortString(int bianwei)
        {
            StringBuilder sb = new StringBuilder();
            // sb.AppendLine(Ming);
            sb.AppendLine(Ben);
            sb.AppendLine(Tuan);
            sb.AppendLine(Xiang);
            sb.AppendLine(Yao[bianwei]);
            return sb.ToString();
        }
    }
}
