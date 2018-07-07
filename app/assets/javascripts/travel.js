class Travel {
  constructor(json){
    this.id          = json.id;
    this.purpose     = json.purpose;
    this.logs        = json.logs;
    this.destination = json.destination;
    this.user        = json.user;
    [this.startDate, this.travelDates] = newTravelDates(json.start_date, json.end_date);
  }

  logsIndexHTML(){
    return (
      '<p><span class="make-italic">&ndash; ' +
      this.logs.map( log => log.title ).join('</span></p><p><span class="make-italic">&ndash; ') +
      '</span></p>'
    );
  }

  toHTML(){
    return (
      `<div class="link-body-container">` +
        `<div class="link-secondary-subcontainer">` +
          `<p><a class="travel-logs-index" href="/travels/${this.id}">Preview</a></p>` +
          `<p><a data-confirm="Are you sure?" rel="nofollow" data-method="delete" href="/travels/${this.id}">Delete</a></p>` +
          `<p><a href="/travels/${this.id}/edit">Edit</a></p>` +
        `</div>` +
        `<a href="/travels/${this.id}" class="link-primary-subcontainer">` +
          `<p>${this.travelDates}</p>` +
          `<p><span class="make-bold">${this.destination.name}</span></p>` +
          `<p>${this.purpose || "No Purpose"}</p>` +
          `<p>0 Travel Logs</p>` +
        `</a>` +
      `</div>`
    );
  }
}

function newTravelDates(jsonStartDate, jsonEndDate){
  const dates = [];
  let d = new Date(jsonStartDate);
  d.setTime( d.getTime() + d.getTimezoneOffset()*60*1000 );
  dates.push( d, formatDateTimeString(d) );
  if (!!jsonEndDate){
    d = new Date(jsonEndDate);
    d.setTime( d.getTime() + d.getTimezoneOffset()*60*1000 );
    dates[1] += ` – ${formatDateTimeString(d)}`;
  }
  return dates;
}
