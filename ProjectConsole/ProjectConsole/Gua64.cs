using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;

namespace ProjectConsole
{
    class Gua64
    {
        Gua8 m_hi;
        Gua8 m_lo;
        int m_bianwei;
        string m_xiang;
        Yao[] m_arrYao;
        GuaCi m_guaci;
        Gua64 m_biangua=null;
        public string Xiang { get => m_xiang; }
        public GuaCi GuaCi { get => m_guaci; }
        public string Yaoci()
        {
            StringBuilder sb = new StringBuilder();
            var biangua = BianGua();
            sb.AppendLine("=====卦辞=====");
            sb.AppendLine(GuaCi.Name + " 之 " + biangua.GuaCi.Name);
            sb.AppendLine("---本卦---");
            sb.AppendLine(GuaCi.ToShortString(m_bianwei));
            sb.AppendLine("---变卦---");
            sb.AppendLine(biangua.GuaCi.ToShortString(m_bianwei));
            return sb.ToString();
        }
        public Gua64(Yao[] t6yao)
        {
            this.m_lo = new Gua8(t6yao[0], t6yao[1], t6yao[2]);
            this.m_hi = new Gua8(t6yao[3], t6yao[4], t6yao[5]);
            this.m_arrYao = t6yao;

            m_bianwei= CalcBianwei();

            if (m_lo.Xiang == m_hi.Xiang)
                m_xiang = m_lo.Xiang;
            else
                m_xiang = m_hi.Xiang + m_lo.Xiang;

            SearchGuaCi();
        }
        void SearchGuaCi()
        {
            bool chong = m_xiang.Length == 1;

            var xmlbook = Properties.Resources.yi;
            XmlDocument zhouyi = new XmlDocument();
            zhouyi.LoadXml(xmlbook);
            var root = zhouyi.LastChild;
            XmlElement gua=null;
            foreach(XmlElement g in root)
            {
                var nameGua = g.GetAttribute("name");
                if (chong && nameGua.Length == 3)
                {
                    if (nameGua.Substring(2) == m_xiang)
                    {
                        gua = g; break;
                    }
                }
                else
                {
                    if (nameGua.Substring(0, 2) == m_xiang)
                    { gua = g; break; }
                }
            }
            if (gua == null) throw new Exception("没查到卦辞");
            m_guaci = new GuaCi(gua);
        }
        public Gua64 BianGua()
        {
            if(m_biangua!=null) return m_biangua;
            Yao[] t6yao = new Yao[6];
            for(int i = 0; i < 6; i++)
            {
                if (m_bianwei == i)
                {
                    t6yao[i] = this[i].CreateBianYao();
                }
                else
                {
                    t6yao[i] = this[i];
                }
            }
            m_biangua= new Gua64(t6yao);
            return m_biangua;
        }
        public Yao this[int index]
        {
            get => m_arrYao[index];
        }
        public string GuaXiangFuhao()
        {
            StringBuilder sb = new StringBuilder();
            for (int i = 5; i >= 0; i--)
            {
                sb.AppendLine(m_arrYao[i].Fuhua);
            }
            return sb.ToString();
        }
        int CalcBianwei()
        {
            int sum = 0;
            for(int i = 0; i < 6; i++)
            {
                sum += this[i].Shu;
            }
            int bw = (55 - sum) % 6;
            if (bw == 0) { bw = 6; }
            bw -= 1;
            return bw;
        }
    }
}
