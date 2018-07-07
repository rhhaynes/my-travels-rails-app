class Log {
  constructor(json){
    this.prevLogPath = json.prev_log_path;
    this.nextLogPath = json.next_log_path;
    this.title       = json.log.title;
    this.createdAt   = formatDateTimeString(json.log.created_at, 'long');
    this.content     = json.log.content;
  }

  insertHTML(){
    $('a.travel-logs-prev').attr('href', this.prevLogPath);
    $('a.travel-logs-next').attr('href', this.nextLogPath);
    $('div.content-header-container h1').html(this.title);
    $('div.content-header-container h3').html(this.createdAt);
    $('div.content-body-container p').html(this.content);
  }
}
