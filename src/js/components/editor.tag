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
  <section contenteditable
    oninput={ onInput }
    onkeypress={ onKeypress }
    onkeydown={ onKeydown }
    oncut={ onCut }
    oncopy={ onCopy }
    onpaste={ onPaste } >
    <paragraph each={ paragraphs } paragraph={ this }/>
  </section>

  this.title = opts.stream.get('title').text;
  this.paragraphs = opts.stream.get('paragraphs').asArray();

  onInput(event) {
    // here 'this' still refers to the tag
    console.trace("onInput:", event);
  }

  onKeypress(event) {
    console.trace("onKeypress:", event);
    // if default handling is ok:
    // return true;
  }

  onKeydown(event) {
    console.trace("onKeydown:", event);
    // if default handling is ok:
    // return true;
  }

  onCut(event) {
    console.trace("onCut:", event);
    // if default handling is ok:
    // return true;
  }

  onCopy(event) {
    console.trace("onCopy:", event);
    // if default handling is ok:
    // return true;
  }

  onPaste(event) {
    console.trace("onPaste:", event);
    // if default handling is ok:
    // return true;
  }
</stream>

<paragraph>
  <p>{ text }</p>

  this.text = opts.paragraph.get('text').text;
</paragraph>
