<?xml version="1.0" encoding="utf-8"?>
<!--
  ______                   ______  _                             _     _       _                         
 / _____)                 (_____ \| |                           | |   | |     | |                        
| /  ___  ____ ____   ____ _____) ) | ____ _   _  ____  ____ ___| |__ | |_   _| | _     ____  ___  ____  
| | (___)/ _  |    \ / _  )  ____/| |/ _  | | | |/ _  )/ ___)___)  __)| | | | | || \   / ___)/ _ \|    \ 
| \____/( ( | | | | ( (/ /| |     | ( ( | | |_| ( (/ /| |  |___ | |   | | |_| | |_) )_( (___| |_| | | | |
 \_____/ \_||_|_|_|_|\____)_|     |_|\_||_|\__  |\____)_|  (___/|_|   |_|\____|____/(_)\____)\___/|_|_|_|
                                          (____/                                                         

File:   SharedFunctions.xslt
Author: Peter DiSalvo
Date:   April 2012

Purpose:  General functions shared by all pages. Functions include
          -Price formatting
          -Date conversion
          -Removal of leading zeros
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- Function converts a number to price format -->
  <xsl:template name="priceFormat">
    <xsl:param name="price" />

    <xsl:value-of select="format-number($price, '$##0.00')" />
  </xsl:template>

  <!-- /* Function converts a date formatted as yyyy-mm-dd to Month dd, yyyy 
        *
        */-->
  <xsl:template name="convertDate">
    <!-- Parameter is a date in the format yyyy-mm-dd -->
    <xsl:param name="date" />

    <!-- Variable holds the numerical month portion of the parameter -->
    <xsl:variable name="monthNum" select="substring($date, 6, 2)" />

    <!-- Variable holds the numerical day portion of the parameter -->
    <xsl:variable name="dayNum" select="substring($date, 9, 2)" />

    <!-- Variable value is assigned based on the contained choose section.
         It is assigned a string month value based on the numerical month value
    -->
    <xsl:variable name="month">
      <xsl:choose>
        <xsl:when test="$monthNum = '01'">January</xsl:when>
        <xsl:when test="$monthNum = '02'">February</xsl:when>
        <xsl:when test="$monthNum = '03'">March</xsl:when>
        <xsl:when test="$monthNum = '04'">April</xsl:when>
        <xsl:when test="$monthNum = '05'">May</xsl:when>
        <xsl:when test="$monthNum = '06'">June</xsl:when>
        <xsl:when test="$monthNum = '07'">July</xsl:when>
        <xsl:when test="$monthNum = '08'">August</xsl:when>
        <xsl:when test="$monthNum = '09'">September</xsl:when>
        <xsl:when test="$monthNum = '10'">October</xsl:when>
        <xsl:when test="$monthNum = '11'">November</xsl:when>
        <xsl:when test="$monthNum = '12'">December</xsl:when>
      </xsl:choose>
    </xsl:variable>

    <!-- Variable holds the numerical day value after
         checking for and removing any zero padding from
         single digit days -->
    <xsl:variable name="day">
      <xsl:call-template name="stripLeadingZero">
        <xsl:with-param name="number" select="$dayNum" />
      </xsl:call-template>
    </xsl:variable>

    <!-- Variable holds the numeric year portion of the date -->
    <xsl:variable name="year" select="substring($date, 1, 4)" />

    <!-- Output a concatenation of the previously created variables
         formatted as Month dd, yyyy -->
    <xsl:value-of select="concat($month, ' ', $day , ', ', $year )" />
  </xsl:template>


  <!-- /* Function converts a date formatted as yyyy-mm-dd to mm/dd/yy 
        *
        */-->
  <xsl:template name="convertDate2">
    <!-- Parameter is a date in the format yyyy-mm-dd -->
    <xsl:param name="date" />
    
    <!-- Variable holds the numerical month portion of the parameter -->
    <xsl:variable name="monthNum" select="substring($date, 6, 2)" />

    <!-- Variable holds the numerical day portion of the parameter -->
    <xsl:variable name="dayNum" select="substring($date, 9, 2)" />

    <!-- Variable holds the numerical day value after
         checking for and removing any zero padding from
         single digit days -->
    <xsl:variable name="day">
      <xsl:call-template name="stripLeadingZero">
        <xsl:with-param name="number" select="$dayNum" />
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="month">
      <xsl:call-template name="stripLeadingZero">
        <xsl:with-param name="number" select="$monthNum" />
      </xsl:call-template>
    </xsl:variable>
    
    <!-- Variable holds the numeric year portion of the date -->
    <xsl:variable name="year" select="substring($date, 3, 2)" />
    
    <!-- Output a concatenation of the previously created variables
         formatted as Month dd, yyyy -->
    <xsl:value-of select="concat($month, '/', $day, '/', $year)" />
  </xsl:template>

  
  <!-- -->
  <xsl:template name="stripLeadingZero">
    <xsl:param name="number" />
    <xsl:choose>
      <!-- Remove front padded zeros from numbers that begin with zero -->
      <xsl:when test="starts-with($number, '0')">
        <xsl:value-of select="substring-after($number, '0')"/>
      </xsl:when>
      <!-- Numerical value does not begin with a zero
             so return the value -->
      <xsl:otherwise>
        <xsl:value-of select="$number" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
