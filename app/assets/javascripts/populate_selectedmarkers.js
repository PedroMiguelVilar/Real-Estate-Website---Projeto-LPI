function populateSelectedMarkersTable(selectedMarkers) {
  var tableBody = document.getElementById("selected-markers-table").getElementsByTagName("tbody")[0];
  for (var i = 0; i < selectedMarkers.length; i++) {
    var row = tableBody.insertRow();
    var nameCell = row.insertCell(0);
    var priceCell = row.insertCell(1);
    var locationCell = row.insertCell(2);
    var link = document.createElement("a"); 
    link.href = '/property_single.' +  selectedMarkers[i].Id;
    link.innerHTML = selectedMarkers[i].Title; 
    nameCell.appendChild(link); 
    priceCell.innerHTML = selectedMarkers[i].Price;
    locationCell.innerHTML = selectedMarkers[i].Localizacao;
  }
}
