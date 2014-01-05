<?xml version="1.0" encoding="utf-8"?>
<!--
  ______                   ______  _                             _     _       _                         
 / _____)                 (_____ \| |                           | |   | |     | |                        
| /  ___  ____ ____   ____ _____) ) | ____ _   _  ____  ____ ___| |__ | |_   _| | _     ____  ___  ____  
| | (___)/ _  |    \ / _  )  ____/| |/ _  | | | |/ _  )/ ___)___)  __)| | | | | || \   / ___)/ _ \|    \ 
| \____/( ( | | | | ( (/ /| |     | ( ( | | |_| ( (/ /| |  |___ | |   | | |_| | |_) )_( (___| |_| | | | |
 \_____/ \_||_|_|_|_|\____)_|     |_|\_||_|\__  |\____)_|  (___/|_|   |_|\____|____/(_)\____)\___/|_|_|_|
                                          (____/                                                         

File:     outputInstructions.xslt
Author:   Peter DiSalvo
Date:     April 2012

Purpose:  Defines default values used during XSL Transformations,
          including constants for XML source page names.
          Use this file to set file extensions for links in the
          output file.
          
          If the output is intended for HTML5 then the document links
          should use ".html" extension.
          
          If the output is intended for browser transformation, then
          document links should use ".xml" extension.
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!--HTML 5 PRODUCTION OUTPUT-->
  <!--<xsl:output method="xml" doctype-system="about:legacy-compat" omit-xml-declaration="yes" encoding="utf-8" indent="yes"/>-->
  <!-- File extension for links between pages is '.html' when parsed output is saved -->
  <!--<xsl:variable name="docLinkExtension" select="'.html'" />-->

  <!--INTERNET EXPLORER XSLT PROCESSOR OUTPUT-->
  <xsl:output method="html" version="4.0" encoding="utf-8" indent="yes"/>
  <!-- File extension for links between pages is .xml when xslt processor is displaying in memory -->
  <xsl:variable name="docLinkExtension" select="'.xml'" />

  <!-- XML pages used for parsing -->
  <xsl:variable name="indexParsePage" select="'index.xml'" />
  <xsl:variable name="gamesParsePage" select="'games.xml'" />
  <xsl:variable name="articlesParsePage" select="'articles.xml'" />
  <xsl:variable name="aboutParsePage" select="'about.xml'" />

  <!-- Page names used for document links in the result document -->
  <xsl:variable name="indexPageName" select="concat('index', $docLinkExtension)" />
  <xsl:variable name="gamesPageName" select="concat('games', $docLinkExtension)" />
  <xsl:variable name="articlesPageName" select="concat('articles', $docLinkExtension)" />
  <xsl:variable name="aboutPageName" select="concat('about', $docLinkExtension)" />

  
</xsl:stylesheet>
