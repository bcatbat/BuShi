using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProjectConsole
{
    class Yao
    {
        public int Shu { get; set; }      // 数;6,7,8,9
        public int Yi { get; set; }          // 仪;阴0阳1
        public string Fuhua {
            get
            {
                return Yi == 0 ? YIN : YANG;
            }
        }    // 象;-- --;-----
       
        public Yao(int shu)
        {
            this.Shu = shu;
            this.Yi = shu % 2;
        }

        public Yao CreateBianYao()
        {
            Yao y = new Yao(Shu);
            y.Yi = 1 - y.Yi;
            return y;
        }

        const string YIN =  "--- ---";
        const string YANG = "-------";
        static readonly string[] XUYI = { "六", "九" };
    }
}
