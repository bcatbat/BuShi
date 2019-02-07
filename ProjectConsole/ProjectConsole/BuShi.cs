using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;

namespace ProjectConsole
{
    class BuShi
    {
        int m_yong;
        int m_tian;
        int m_di;
        int m_ren;
        StringBuilder m_info=null;

        public Gua64 ChengGua(string seed)
        {
            m_info =new StringBuilder();
            m_info.AppendLine("====卜蓍开始====");
            m_r= new Random(CreateSeed(seed));
            Yao[] t6yao = new Yao[6];
            for(int i = 0; i < 6; i++)
            {
                m_info.AppendLine("==爻"+(i+1)+"==");
                int yaoshu=DieYao(i);
                m_info.AppendLine("爻数:"+yaoshu);
                t6yao[i] = new Yao(yaoshu);
            }
            return new Gua64(t6yao);
        }
        public string GetInfo(){
            if(m_info==null) return "需要先成卦";
            return m_info.ToString();}
        int DieYao(int y)
        {
            m_yong = DAYAN - 1;
            for (int i = 0; i < 3; i++)
            {
                m_info.AppendLine("--揲"+(i+1)+"--");
                m_info.AppendLine("用:"+m_yong);
                FenEr(out m_tian, out m_di);
                GuaYi(ref m_di, out m_ren);
                m_info.AppendLine("天:"+m_tian+"\t地:"+m_di+"\t人:"+m_ren);
                m_yong = Die(m_tian, m_di, m_ren);
            }
            return m_yong / 4;
        }
        void FenEr(out int tian,out int di)
        {
            tian = m_r.Next(1, m_yong - 1);
            di = m_yong - tian;
        }
        void GuaYi(ref int di,out int ren)
        {
            di = di - 1;
            ren = 1;
        }
        int Die(int tian,int di,int ren)
        {
            m_info.AppendLine("抟:");
            int leftTian = Tuan(tian);
            int leftDi = Tuan(di);
            int leftRen = Tuan(ren);
            m_info.AppendLine("天:"+leftTian+"\t地:"+leftDi+"\t人:"+leftRen);
            return m_yong - leftTian - leftDi - leftRen;
        }
        int Tuan(int g)
        {
            int t = g % 4;
            if (t == 0) { t = 4; }
            return t;
        }
        int CreateSeed(string seed)
        {
            var now = DateTime.Now;
            m_info.AppendLine(now.ToString());
            m_info.AppendLine(seed);
            var ticks = DateTime.Now.Ticks;
            string s = now + seed;
            byte[] bs = Encoding.Default.GetBytes(s);

            int num = 0;
            for (int i = 0; i < bs.Length; i++)
            {
                num = (num + bs[i]) * bs[i];
            }
            num += (int)ticks;
            m_info.AppendLine("随机种子:"+num);
            return num;
        }
        Random m_r;
        const int DAYAN = 50;
    }
}
