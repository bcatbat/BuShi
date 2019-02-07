using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProjectConsole
{
    class Gua8
    {
        public string Name { get => m_name; }
        public string Xiang { get => m_xiang; }
        string m_name;
        string m_xiang;
        
        public Gua8(Yao xia,Yao zhong,Yao shang)
        {
            int n = xia.Yi + zhong.Yi * 2 + shang.Yi * 4;
            m_xiang = T8Xiang[n];
            m_name = T8Gua[n];            
        }

        public static readonly string[] T8Xiang
            = { "地", "雷", "水", "泽", "山", "火", "风", "天" };
        public static readonly string[] T8Gua
            = { "坤", "震", "坎", "兑", "艮", "离", "巽", "乾" };

    }
}
