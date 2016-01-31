import './stream.tag'

<editor>
  <table width='100%'>
    <tr>
      <td each={ stream, i in streams } width='50%' valign='top'>
        <stream stream={ stream }></stream>
      </td>
    </tr>
  </table>

  this.on('update', function() {
    console.trace('editor update');
    this.streams = opts.streams();
  });
</editor>
