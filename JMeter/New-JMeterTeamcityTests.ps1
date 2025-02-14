<#
The MIT License (MIT)

Copyright (c) 2015 Objectivity Bespoke Software Specialists

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
#>

function New-JMeterTeamcityTests {
    <#
    .SYNOPSIS
    Generates a standard set of tests reported to TeamCity, basing on JMeter Aggregate Report CSV file.
    Invokes 'ConvertTo-TeamcityTest' function several times.

    .PARAMETER JMeterAggregateReportCsvPath
    Path to the input JMeter Aggregate Report csv (generated by New-JMeterAggregateReport).

    .PARAMETER FailureThreshold
    Threshold for JMeter error%, above which test will be marked as failed.

    .PARAMETER ColumnsToReportAsTests
    List of columns that will be reported as TeamCity tests (each column will be mapped to one category).
    For example, if $ColumnsToReportsAsTests = @('average','median') and you have tests 'x', 'y', there will be
    tests average.x, average.y, median.x, median.y

    .PARAMETER BuildStatisticTestName
    Name of test that will be reported as TeamCity custom metrics.

    .PARAMETER IncludeTotal
    If true, 'TOTAL' row will also be included as TeamCity test.

    .LINK
    New-JMeterAggregateReport
    ConvertTo-TeamcityTest

    .EXAMPLE
    New-JMeterTeamcityTests -JMeterAggregateReportCsvPath "AggregateReport.csv" -FailureThreshold 0
    #>

    [CmdletBinding()]
    [OutputType([string[]])]
    param(
        [Parameter(Mandatory=$true)]
        [string]
        $JMeterAggregateReportCsvPath,

        [Parameter(Mandatory=$false)]
        [decimal]
        $FailureThreshold,

        [Parameter(Mandatory=$false)]
        [string[]]
        $ColumnsToReportAsTests = @('average', 'aggregate_report_median', 'aggregate_report_90%_line'),

        [Parameter(Mandatory=$false)]
        [string]
        $BuildStatisticTestName = 'TOTAL',

        [Parameter(Mandatory=$false)]
        [switch]
        $IncludeTotal
    )

    $testSuiteName = 'JMeter'

    $prefixMapping = @{ 
        'aggregate_report_count' = 'Count.';
        'average' = 'Average.';
        'aggregate_report_median' = 'Median.';
        'aggregate_report_90%_line' = '90Line.';
        'aggregate_report_min' = 'Min.';
        'aggregate_report_max' = 'Max.';
        'aggregate_report_error%' = 'Error.';
        'aggregate_report_rate' = 'Rate.';
        'aggregate_report_bandwidth' = 'Bandwidth.';
        'aggregate_report_stddev' = 'StdDev.';
    }

    if ($IncludeTotal) {
        $ignoredTests = ""
    } else {
        $ignoredTests = "TOTAL"
    }

    if ($FailureThreshold) {
        $FailureThreshold = $FailureThreshold / 100
    }

    foreach ($column in $ColumnsToReportAsTests) {
        if (!$prefixMapping.ContainsKey($column)) {
            Write-Log -Critical "Unrecognized column name: '$column'. Allowed values: $($prefixMapping.Keys)"
        }
        ConvertTo-TeamcityTest -CsvInputFilePath $JMeterAggregateReportCsvPath -TestSuiteName $testSuiteName -FailureThreshold $FailureThreshold `
            -ColumnTestName "sampler_label" -ColumnTestTime $column -ColumnTestFailure "aggregate_report_error%" -TestClassNamePrefix $prefixMapping.$column `
            -IgnoreTestNames $ignoredTests
    }

    if ($BuildStatisticTestName) {
        ConvertTo-TeamcityTest -CsvInputFilePath $JMeterAggregateReportCsvPath `
            -ColumnTestName "sampler_label" -ColumnTestTime "average" -BuildStatisticTestName $BuildStatisticTestName -BuildStatisticName "JMeterAverage"

        ConvertTo-TeamcityTest -CsvInputFilePath $JMeterAggregateReportCsvPath `
            -ColumnTestName "sampler_label" -ColumnTestTime "aggregate_report_median" -BuildStatisticTestName $BuildStatisticTestName -BuildStatisticName "JMeterMedian"

        ConvertTo-TeamcityTest -CsvInputFilePath $JMeterAggregateReportCsvPath `
            -ColumnTestName "sampler_label" -ColumnTestTime "aggregate_report_90%_line" -BuildStatisticTestName $BuildStatisticTestName -BuildStatisticName "JMeter90Line"

        ConvertTo-TeamcityTest -CsvInputFilePath $JMeterAggregateReportCsvPath `
            -ColumnTestName "sampler_label" -ColumnTestTime "aggregate_report_error%" -BuildStatisticTestName $BuildStatisticTestName -BuildStatisticName "JMeterErrors"
    }

}
