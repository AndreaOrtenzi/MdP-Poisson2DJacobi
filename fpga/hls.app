<project xmlns="com.autoesl.autopilot.project" name="fpga" top="kernel" projectType="C/C++">
    <includePaths/>
    <libraryPaths/>
    <Simulation argv="-fcommon">
        <SimFlow name="csim" clean="true" csimMode="0" lastCsimMode="0"/>
    </Simulation>
    <files xmlns="">
        <file name="fpga/kernel.cpp" sc="0" tb="false" cflags="" csimflags="" blackbox="false"/>
        <file name="../16_16_200000_0.000010.ref" sc="0" tb="1" cflags="-Wno-unknown-pragmas" csimflags="" blackbox="false"/>
        <file name="../checker.h" sc="0" tb="1" cflags="-Wno-unknown-pragmas" csimflags="" blackbox="false"/>
        <file name="../kernel.h" sc="0" tb="1" cflags="-Wno-unknown-pragmas" csimflags="" blackbox="false"/>
        <file name="../reference.h" sc="0" tb="1" cflags="-Wno-unknown-pragmas" csimflags="" blackbox="false"/>
        <file name="../testbench.cpp" sc="0" tb="1" cflags="-Wno-unknown-pragmas" csimflags="" blackbox="false"/>
    </files>
    <solutions xmlns="">
        <solution name="solution1" status="active"/>
    </solutions>
</project>

