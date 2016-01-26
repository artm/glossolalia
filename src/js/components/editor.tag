<editor>
  <table width='100%'>
    <tr>
      <td each={ streams } width='50%'>
        <stream stream={ this }></stream>
      </td>
    </tr>
  </table>

  var root = doc.getModel().getRoot();
  this.streams = root.get('streams').asArray();
</editor>

<stream>
  <h1>{ title }</h1>
  <section contenteditable>
    <paragraph each={ paragraphs } paragraph={ this }/>
  </section>

  this.title = opts.stream.get('title').text;
  this.paragraphs = opts.stream.get('paragraphs').asArray();
</stream>

<paragraph>
  <p>{ text }</p>

  this.text = opts.paragraph.get('text').text;
</paragraph>
