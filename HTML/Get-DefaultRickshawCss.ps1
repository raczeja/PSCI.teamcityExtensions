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

function Get-DefaultRickshawCss {

    <#
    .SYNOPSIS
    Returns a CSS for styling Rickshaw.

    .EXAMPLE
    Get-DefaultRickshawCss
    #>

    [CmdletBinding()]
    [OutputType([string])]
    param()

return @"
.rickshaw_graph {
	position: relative;
    display: inline-block;
    vertical-align: top;
    border: 1px solid #f0f0f0;
}
.rickshaw_graph svg {
	display: block;	
	overflow: hidden;
}
/* ticks */

.rickshaw_graph .y_axis,
.rickshaw_graph  .x_axis_d3 {
	fill: none;
}
.rickshaw_graph .y_ticks .tick line,
.rickshaw_graph .x_ticks_d3 .tick {
	stroke: rgba(0, 0, 0, 0.16);
	stroke-width: 2px;
	shape-rendering: crisp-edges;
	pointer-events: none;
}
.rickshaw_graph .y_grid .tick,
.rickshaw_graph .x_grid_d3 .tick {
	z-index: -1;
	stroke: rgba(0, 0, 0, 0.20);
	stroke-width: 1px;
	stroke-dasharray: 1 1;
}
.rickshaw_graph .y_grid .tick[data-y-value="0"] {
	stroke-dasharray: 1 0;
}
.rickshaw_graph .y_grid path,
.rickshaw_graph .x_grid_d3 path  {
	fill: none;
	stroke: none;
}
.rickshaw_graph .y_ticks path,
.rickshaw_graph .x_ticks_d3 path {
	fill: none;
	stroke: #808080;
}
.rickshaw_graph .y_ticks text,
.rickshaw_graph .x_ticks_d3 text {
	font-size: 13px;
	pointer-events: none;
}

/* details */
.rickshaw_graph .detail {
	pointer-events: none;
	position: absolute;
	top: 0;
	z-index: 2;
	background: rgba(0, 0, 0, 0.1);
	bottom: 0;
	width: 1px;
	transition: opacity 0.25s linear;
	-moz-transition: opacity 0.25s linear;
	-o-transition: opacity 0.25s linear;
	-webkit-transition: opacity 0.25s linear;
}
.rickshaw_graph .detail.inactive {
	opacity: 0;
}
.rickshaw_graph .detail .item.active {
	opacity: 1;
}
.rickshaw_graph .detail .x_label {
	font-family: Arial, sans-serif;
	border-radius: 3px;
	padding: 6px;
	opacity: 0.5;
	border: 1px solid #e0e0e0;
	font-size: 12px;
	position: absolute;
	background: white;
	white-space: nowrap;
}
.rickshaw_graph .detail .x_label.left {
	left: 0;
}
.rickshaw_graph .detail .x_label.right {
	right: 0;
}
.rickshaw_graph .detail .item {
	position: absolute;
	z-index: 2;
	border-radius: 3px;
	padding: 0.25em;
	font-size: 12px;
	font-family: Arial, sans-serif;
	opacity: 0;
	background: rgba(0, 0, 0, 0.4);
	color: white;
	border: 1px solid rgba(0, 0, 0, 0.4);
	margin-left: 1em;
	margin-right: 1em;
	margin-top: -1em;
	white-space: nowrap;
}
.rickshaw_graph .detail .item.left {
	left: 0;
}
.rickshaw_graph .detail .item.right {
	right: 0;
}
.rickshaw_graph .detail .item.active {
	opacity: 1;
	background: rgba(0, 0, 0, 0.8);
}
.rickshaw_graph .detail .item:after {
	position: absolute;
	display: block;
	width: 0;
	height: 0;

	content: "";

	border: 5px solid transparent;
}
.rickshaw_graph .detail .item.left:after {
	top: 1em;
	left: -5px;
	margin-top: -5px;
	border-right-color: rgba(0, 0, 0, 0.8);
	border-left-width: 0;
}
.rickshaw_graph .detail .item.right:after {
	top: 1em;
	right: -5px;
	margin-top: -5px;
	border-left-color: rgba(0, 0, 0, 0.8);
	border-right-width: 0;
}
.rickshaw_graph .detail .dot {
	width: 4px;
	height: 4px;
	margin-left: -3px;
	margin-top: -3.5px;
	border-radius: 5px;
	position: absolute;
	box-shadow: 0 0 2px rgba(0, 0, 0, 0.6);
	box-sizing: content-box;
	-moz-box-sizing: content-box;
	background: white;
	border-width: 2px;
	border-style: solid;
	display: none;
	background-clip: padding-box;
}
.rickshaw_graph .detail .dot.active {
	display: block;
}

/* legend */
.rickshaw_legend {
	font-family: Arial;
	font-size: 12px;
	color: white;
	background-color: white;
	display: inline-block;
	border-radius: 2px;
	position: relative;
    vertical-align: top;
    margin-right: 3px;
    width: 390px;
    max-height: 500px;
    overflow: auto;

}
.rickshaw_legend:hover {
	z-index: 10;
}
.rickshaw_legend .swatch {
	width: 10px;
	height: 10px;
	border: 1px solid rgba(0, 0, 0, 0.2);
}
.rickshaw_legend .line {
	clear: both;
	line-height: 140%;
	padding-right: 15px;
    background-color: white;
    color: black;
}
.rickshaw_legend .line:hover {
	background-color: #DDD;
}
.rickshaw_legend .line .swatch {
	display: inline-block;
	margin-right: 3px;
	border-radius: 2px;
}
.rickshaw_legend .label {
	margin: 0;
	white-space: nowrap;
	display: inline;
	font-size: inherit;
	background-color: transparent;
	color: inherit;
	font-weight: normal;
	line-height: normal;
	padding: 0px;
	text-shadow: none;
}
.rickshaw_legend .action:hover {
	opacity: 0.6;
}
.rickshaw_legend .action {
	margin-right: 0.2em;
	font-size: 10px;
	cursor: pointer;
	font-size: 14px;
    color: black;
	opacity: 0.5;
}
.rickshaw_legend .line.disabled {
	opacity: 0.4;
}
.rickshaw_legend ul {
	list-style-type: none;
	margin: 0;
	padding: 0;
	margin: 2px;
	cursor: pointer;
}
.rickshaw_legend li {
	padding: 0 0 0 2px;
	min-width: 80px;
	white-space: nowrap;
}
.rickshaw_legend li:hover {
	background: rgba(255, 255, 255, 0.08);
	border-radius: 3px;
}
.rickshaw_legend li:active {
	background: rgba(255, 255, 255, 0.2);
	border-radius: 3px;
} 

/* extensions */

#chartContainer {
	position: relative;
	display: inline-block;
    font-family: Arial, sans-serif;
}

#contentChart {
    width: 1300px;
    margin-left: auto;
    margin-right: auto;
    margin-top: 15px;
}

#options {
    text-align: center;
    width: 1300px;
    margin-left: auto;
    margin-right: auto;
}

#chartFilterForm label {
   margin-left: 5px;
}

#chartFilterForm #testHistoryNumber {
    width: 32px;
    margin-right: 5px;
}

#chartFilterForm #testCategoryContains {
    width: 150px;
    margin-right: 5px;
}

"@

}