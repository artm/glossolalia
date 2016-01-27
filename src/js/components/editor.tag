import './stream.tag'

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
