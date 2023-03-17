function populateSelectedMarkersTable(selectedMarkers) {
    var tableBody = document.getElementById("selected-markers-table").getElementsByTagName("tbody")[0];
    tableBody.innerHTML = "";
    for (var i = 0; i < selectedMarkers.length; i++) {
      var row = tableBody.insertRow(i);
      var nameCell = row.insertCell(0);
      var priceCell = row.insertCell(1);
      var locationCell = row.insertCell(2);
      nameCell.innerHTML = selectedMarkers[i].Title;
      priceCell.innerHTML = selectedMarkers[i].Price;
      locationCell.innerHTML = selectedMarkers[i].Localizacao;
    }
}
