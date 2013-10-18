# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Abstract data type for a table with sortable columns. Constructor takes a
# CSS selector (id is the safest) and creates the corresponding Table object.
# This reads the rows and extracts the text content to keep track of the
# order of the table. Requires a table with a uniform number of columns and
# rows (i.e. no merged cells). Handles alphabetic, numeric, and date sorting.
#
# selector: jQuery-recognizable CSS selector (e.g. element, .class, #id)
#
# Rep invariant: The dimensions and content of the table should not change or
# dynamically update while the user is on the page. The row data is read on
# page render and for the purposes of client-side sorting, remains static.
Table = (selector) ->
  # determine table dimensions
  rows = $(selector).find('tbody tr').length
  cols = $(selector).find('th').length

  # extract data (unstructured)
  data = []
  $(selector).find('tbody td a').each ->
    data.push $(this).html()

  # structure data as an object
  table =
    rows:
      0: ''
    cols:
      0: ''
  table['rows'][r] = (data[r * cols...((r + 1) * cols)]) for r in [0...rows]
  table['cols'][c] = (cell for cell in data[c..] by cols) for c in [0...cols]

  self =
    # Returns the number of rows in the table. Mainly used for testing purposes.
    rows: -> rows

    # Returns the number of columns in the table. Mainly used for testing purposes.
    cols: -> cols

    # Returns the object containing the table data. Mainly used for testing purposes.
    table: -> table

    # Returns the content of a specified row as an array of strings.
    # r: row number to read (zero-indexed)
    row: (r) -> table['rows'][r]

    # Returns the content of a specified column as an array of strings.
    # c: column number to read (zero-indexed)
    col: (c) -> table['cols'][c]
    
    # Sorts the table upon a particular column.
    # c: the column to sort upon
    # d: the direction to sort (0 - desc, 1 - asc)
    sort: (c, d) ->
      # read and duplicate column
      presort = self.col c
      sorted = presort[..]

      # sort the column
      date = new Date sorted[0]
      if isNaN date.getMonth()
        numeric = true
        numeric = (!isNaN(parseInt(c)) && numeric) for c in sorted
        if numeric
          # numeric
          sorted.sort (a, b) -> parseInt(a) - parseInt(b)
        else
          # alphabetic
          sorted.sort()
      else
        # chronologic
        sorted.sort (a, b) ->
          d1 = new Date a
          d2 = new Date b
          result = if d1 < d2 then 1 else if d1 < d2 then -1 else 0
        sorted.reverse()

      # reverse direction if needed
      if d is 0 then sorted.reverse()

      # array containing the swap order
      order = (presort.indexOf pos for pos in sorted)
      
      # update table
      new_table =
        rows:
          0: ''
        cols:
          0: ''
      new_table['rows'][i] = table['rows'][order[i]] for i in [0...rows]
      new_table['cols'][j] = (table['cols'][j][order[i]] for i in [0...rows]) for j in [0...cols]
      table = new_table

      # return this for jQuery to use
      order

# initialize the table object for this page
t = Table('#notes')

# event listener for sorting
$('#notes th').click ->
  # define rows to be sorted
  rows = $('#notes tbody tr')

  # determine direction of sort, update classes
  if $(this).hasClass('sort-desc')
    order = t.sort($(this).prevAll().length, 1)
    $('.sort-asc, .sort-desc').removeClass('sort-asc').removeClass('sort-desc')
    $(this).addClass('sort-asc')
  else
    order = t.sort($(this).prevAll().length, 0)
    $('.sort-asc, .sort-desc').removeClass('sort-asc').removeClass('sort-desc')
    $(this).addClass('sort-desc')

  # reorder rows
  $('#notes tbody').append(rows[order[i]]) for i in [0...rows.length]

# activate chosen plugin
$(document).ready ->
  $("#note_user_ids").chosen().css('visibility', 'visible');
