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
        private Double startmu = 0;
        private Double startsigma = 0;
        private Double multiplier = 200;
        private UInt16 decay = 0;
        private UInt32 decayValue = 1;
        private UInt32 minMatches = 1;

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

        public Double StartMu
        {
            get { return startmu; }
            set { startmu = value; }
        }

        public Double StartSigma
        {
            get { return startsigma; }
            set { startsigma = value; }
        }

        public Double Multiplier
        {
            get { return multiplier; }
            set { multiplier = value; }
        }

        public UInt16 Decay
        {
            get { return decay; }
            set { decay = value; }
        }

        public UInt32 DecayValue
        {
            get { return decayValue; }
            set { decayValue = value; }
        }

        public UInt32 MinMatches
        {
            get { return minMatches; }
            set { minMatches = value; }
        }
    }
}
