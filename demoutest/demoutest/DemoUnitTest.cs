using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.VisualStudio.TestPlatform.UnitTestFramework;

namespace demoutest
{
    [TestClass]
    public class DemoUnitTest
    {
        [TestMethod]
        public void PassDemoMethod()
        {
            Assert.IsTrue(2 > 1);
        }


        [TestMethod]
        public void FailDemoMethod()
        {
            Assert.IsTrue(1 > 2);
        }
    }
}
