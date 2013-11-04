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
    <xsl:apply-templates select="exsl:node-set($html-composited)//h:html"/>
  </xsl:template>

  <xsl:template match="@*|node()" mode="composite-html">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" mode="composite-html"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="h:section[contains(@data-type, 'copyright-page')]" mode="composite-html">
    <xsl:copy-of select="document('theme/pdf/copyright.html')"/>
  </xsl:template>
  
  <xsl:template match="h:html">
    <xsl:call-template name="generate.mimetype"/>
    <xsl:call-template name="generate.meta-inf"/>
    <xsl:call-template name="generate.opf"/>
    <xsl:if test="$generate.ncx.toc = 1">
      <xsl:call-template name="generate.ncx.toc"/>
    </xsl:if>
    <xsl:if test="$generate.cover.html = 1">
      <xsl:call-template name="generate-cover-html"/>
    </xsl:if>
    <xsl:apply-imports/>
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
