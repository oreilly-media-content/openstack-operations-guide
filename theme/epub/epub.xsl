<xsl:stylesheet version="1.0"
		xmlns:exsl="http://exslt.org/common"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:h="http://www.w3.org/1999/xhtml"
                xmlns="http://www.w3.org/1999/xhtml"
		extension-element-prefixes="exsl"
                exclude-result-prefixes="h exsl">

<!-- Pull in custom HTML content prior to generating EPUB -->
  <xsl:template match="/">
    <xsl:variable name="html-composited">
      <wrapper>
	<xsl:copy>
	  <xsl:apply-templates select="*" mode="composite-html"/>
	</xsl:copy>
      </wrapper>
    </xsl:variable>
    <xsl:apply-templates select="exsl:node-set($html-composited)//h:html">
      <xsl:with-param name="html-composited" select="$html-composited"/>
  </xsl:template>

  <xsl:template match="@*|node()" mode="composite-html">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" mode="composite-html"/>
    </xsl:copy>
  </xsl:template>

  <!-- Insert copyright page when preprocessing HTML -->
  <xsl:template match="h:section[contains(@data-type, 'copyright-page')]" mode="composite-html">
    <xsl:copy-of select="document('theme/pdf/copyright.html')"/>
  </xsl:template>
  
  <xsl:template match="h:html">
    <xsl:param name="html-composited"/>
    <xsl:call-template name="generate.mimetype"/>
    <xsl:call-template name="generate.meta-inf"/>
    <xsl:call-template name="generate.opf"/>
    <xsl:if test="$generate.ncx.toc = 1">
      <xsl:call-template name="generate.ncx.toc">
	<xsl:with-param name="html-composited" select="$html-composited"/>
    </xsl:if>
    <xsl:if test="$generate.cover.html = 1">
      <xsl:call-template name="generate-cover-html"/>
    </xsl:if>
    <xsl:apply-imports/>
  </xsl:template>

    <!-- Generate an NCX file from HTMLBook source. -->
    <!-- Overridden here to generate NCX from composited HTML -->
  <xsl:template name="generate.ncx.toc">
    <xsl:param name="html-composited"/>
    <exsl:document href="{$full.ncx.filename}" method="xml" encoding="UTF-8">
      <ncx version="2005-1">
	<head>
	  <xsl:if test="$generate.cover.html = 1">
	    <meta name="cover" content="{$epub.cover.html.id}"/>
	  </xsl:if>
	  <meta name="dtb:uid" content="{$metadata.unique-identifier}"/>
	</head>
	<docTitle>
	  <text>
	    <xsl:value-of select="$metadata.title"/>
	  </text>
	</docTitle>
	<xsl:variable name="navMap">
	  <navMap>
	    <!-- Only put root chunk in the NCX TOC if $ncx.include.root.chunk is enabled -->
	    <xsl:if test="$ncx.include.root.chunk = 1">
	      <navPoint>
		<xsl:attribute name="id">
		  <!-- Use OPF ids in NCX as well -->
		  <xsl:apply-templates select="/*" mode="opf.id"/>
		</xsl:attribute>
		<navLabel>
		  <text>
		    <!-- Look for title first in head, then as child of body -->
		    <xsl:value-of select="(//h:head/h:title|//h:body/h:h1)[1]"/>
		  </text>
		</navLabel>
	      <content src="{$root.chunk.filename}"/>
	      </navPoint>
	    </xsl:if>
	    <!-- BEGIN ORM OVERRIDE -->
	    <xsl:apply-templates select="exsl:node-set($html-composited)//h:html" mode="ncx.toc.gen"/>
	    <!-- END ORM OVERRIDE -->
	  </navMap>
	</xsl:variable>
	<xsl:apply-templates select="exsl:node-set($navMap)" mode="output.navMap.with.playOrder"/>
      </ncx>
    </exsl:document>
  </xsl:template>

<!-- Pull in author name from OpenStack source -->
<xsl:template match="h:section[contains(@data-type, 'titlepage')]/h:h2">
 <h2>
   <xsl:attribute name="data-type">author</xsl:attribute>
   <xsl:copy-of select="document('theme/pdf/copyright.html')//h:p[@class='author']"/>
 </h2>
</xsl:template>   

<!-- Drop hard pagebreak PIs from OpenStack source -->
<xsl:template match="processing-instruction()[contains(name(), 'hard-pagebreak')]"/>

<!-- Insert revision table at revhistory PI -->
<xsl:template match="processing-instruction('rax')[normalize-space(.) = 'revhistory']">
    <table>
      <thead>
        <tr>
          <th>Revision Date</th>
          <th>Summary of Changes</th>
        </tr>
      </thead>
      <tbody>
      <tr>
        <td>
          <p>2013-05-13</p>
        </td>
        <td>
          <ul>
            <li><p>Updated description of availability zones.</p></li>
          </ul>
        </td>
      </tr>
      <tr>
        <td>
          <p>2013-04-02</p>
        </td>
        <td>
          <ul>
            <li><p>Fixes to ensure samples fit in page size and notes are formatted.</p></li>
          </ul>
        </td>
      </tr>
      <tr>
        <td>
          <p>2013-03-22</p>
        </td>
        <td>
          <ul>
            <li><p>Stopped chunking in HTML output.</p></li>
          </ul>
        </td>
      </tr>
      <tr>
        <td>
          <p>2013-03-20</p>
        </td>
        <td>
          <ul>
            <li><p>Editorial changes.</p></li>
            <li><p>Added <code>glossterm</code> tags to glossary terms.</p></li>
            <li><p>Cleaned up formatting in code examples.</p></li>
            <li><p>Removed future tense.</p></li>
          </ul>
        </td>
      </tr>
      <tr>
        <td>
          <p>2013-03-11</p>
        </td>
        <td>
          <ul>
            <li><p>Moved files to OpenStack github repository.</p></li>
          </ul>
        </td>
      </tr>
      </tbody>
   </table>
</xsl:template>

</xsl:stylesheet>
