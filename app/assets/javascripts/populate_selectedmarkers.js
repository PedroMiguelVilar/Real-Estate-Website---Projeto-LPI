function populateSelectedMarkersTable(selectedMarkers, numColumns) {
  var tableBody = document.getElementById("selected-markers-table").getElementsByTagName("tbody")[0];
  var template = `
    <div>
      <div class="card-box-a card-shadow">
        <div class="img-box-a">
          <img src="{{imageUrl}}" width="350" height="350" alt="" class="img-a img-fluid" style="width: 350px !important; height: 350px !important;">
        </div>
        <div class="card-overlay">
          <div class="card-overlay-a-content">
            <div class="card-header-a">
              <h2 class="card-title-a">
                <a href="#">{{location}}</a>
              </h2>
            </div>
            <div class="card-body-a">
              <div class="price-box d-flex">
                <span class="price-a">{{status}} | {{price}}€</span>
              </div>
              <a href="/property_single.{{id}}" class="link-a">Details</a>
              <span class="ion-ios-arrow-forward"></span>
            </div>
            <div class="card-footer-a">
              <ul class="card-info d-flex justify-content-around">
                <li>
                  <h4 class="card-info-title">Area</h4>
                  <span>{{area}}m<sup>2</sup></span>
                </li>
                <li>
                  <h4 class="card-info-title">Bedrooms</h4>
                  <span>{{bedrooms}}</span>
                </li>
                <li>
                  <h4 class="card-info-title">Condition</h4>
                  <span>{{condition}}</span>
                </li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>
  `;
  var row, cell, html, houseIndex;
  for (var i = 0; i < selectedMarkers.length; i++) {
    houseIndex = i % numColumns;
    if (houseIndex == 0) {
      row = tableBody.insertRow();
    }
    cell = row.insertCell(houseIndex);
    html = template.replace('{{imageUrl}}', selectedMarkers[i].ImageUrl || 'img/house-default.jpg')
                      .replace('{{location}}', selectedMarkers[i].Localizacao)
                      .replace('{{status}}', selectedMarkers[i].Situacao)
                      .replace('{{price}}', selectedMarkers[i].Price|| '')
                      .replace('{{id}}', selectedMarkers[i].Id)
                      .replace('{{area}}', selectedMarkers[i].Area_Util || '')
                      .replace('{{bedrooms}}', selectedMarkers[i].Total_quartos || '')
                      .replace('{{condition}}', selectedMarkers[i].Condicao || '');
    cell.innerHTML = html;
  }
}
