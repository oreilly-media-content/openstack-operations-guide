<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:h="http://www.w3.org/1999/xhtml"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns="http://www.w3.org/1999/xhtml"
                exclude-result-prefixes="exsl h">

<!-- Pull in O'Reilly copyright page file -->
<xsl:template match="//book/title">
  <section data-type='copyright-page'>
  <h1>OpenStack Operations Guide</h1>
  <p class='author'>
    by
    <span class='firstname'>Tom </span>
    <span class='surname'>Fifield</span>
    <span>, </span>
    <span class='firstname'>Lorin </span>
    <span class='surname'>Hochstein</span>
    <span>, </span>
    <span class='firstname'>Jonathan </span>
    <span class='surname'>Proulx</span>
    <span>, </span>
    <span class='firstname'>Everett </span>
    <span class='surname'>Toews</span>
    <span>, and </span>
    <span class='firstname'>Joe </span>
    <span class='surname'>Topjian</span>
  </p>
  </section>
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
