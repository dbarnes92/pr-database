using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SkillKeeper
{
    class World
    {
        private String filename = "", name = "";
        private int id = 0;

        public String Filename
        {
            get { return filename; }
            set { filename = value; }
        }

        public String Name
        {
            get { return name; }
            set { name = value; }
        }

        public int Id
        {
            get { return id; }
            set { id = value; }
        }
    }
}
