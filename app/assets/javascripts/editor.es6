class Editor {
  constructor(form) {
    this.form = $(form)
      .on("input, change", ":input", this.fieldChanged.bind(this))
      .on("mousedown", ".ability .base", this.dragAbilityStart.bind(this))
      .on("submit", this.save.bind(this));
  }

  fieldChanged(e) {
    this.scheduleCheck();
  }

  scheduleCheck() {
    clearTimeout(this._pendingCheck);
    this._pendingCheck = setTimeout(this.check.bind(this), 500);
  }

  sendAJAXData(url, data = {}) {
    var json = this.toJSON();

    data = $.extend({
      url: url,
      type: "post",
      dataType: "json",
      contentType: "application/json",
      data: JSON.stringify(json)
    }, data);

    // TODO handle errors
    return $.ajax(data).done(this.processJSON.bind(this));
  }

  check() {
    this.sendAJAXData("/characters/check");
  }

  save(e) {
    var id = this.form.find("#character_id").val(),
      url = id ? "/characters/" + id : "/characters",
      method = id ? "put" : "post";

    if (e) {
      e.preventDefault();
    }

    this.sendAJAXData(url, { type: method })
      .done(function(data) {
        if (data.id.toString() != id) {
          this.form.find("#character_id").val(data.id);
          history.replaceState({}, document.title, "/characters/" + data.id);
        }
      }.bind(this));
  }

  processJSON(data) {
    this.updateValues("character", data);
    this.updateAttributes(data.abilities);
  }

  updateValues(root, data) {
    if ($.isPlainObject(data)) {
      for (var key of Object.keys(data)) {
        this.updateValues(root + "[" + key + "]", data[key]);
      }
    } else {
      this.form.find("[name='" + root + "']").val(data);
    }
  }

  updateAttributes(abilities) {
    for (var key of Object.keys(abilities.stats)) {
      var stat = abilities.stats[key];
      this.form.find("[data-ability=" + key + "]")
        .find(".score").text(stat.score).end()
        .find(".modifier").text(this.signed(stat.modifier)).end()
        .find(".bonus").text(this.signed(stat.bonus)).end()
        .find(".base")
          .prop("disabled", !abilities.strategy.editable)
          .attr("min", stat.min)
          .attr("max", stat.max)
        .end();
    }

    this.form.find(".points").toggle(abilities.strategy.hasOwnProperty("points_remaining"));
  }

  signed(number) {
    return (number < 0 ? "" : "+") + number;
  }

  toJSON() {
    var name, value, input, json = {};

    this.form.find(":input").each(function (i, input) {
      input = $(input);

      if (name = input.attr("name")) {
        if (input.is("select")) {
          value = input.find(":selected").attr("value")
        } else {
          switch (input.attr("type")) {
            case "number":
              value = parseInt(input.val(), 10);
              break;
            default:
              value = input.val();
          }
        }

        this.setJSONValue(json, name.replace(/^[^\[]+\[|\]$/g, "").split("]["), value);
      }
    }.bind(this));

    return json;
  }

  setJSONValue(root, parts, value) {
    var key = parts.shift();

    if (parts.length == 0) {
      root[key] = value;
    } else {
      root[key] = root[key] || {};
      this.setJSONValue(root[key], parts, value);
    }
  }

  dragAbilityStart(e) {
    var source = $(e.target), position = source.offset();

    this._drag = {
      source: source,
      origin: { x: e.pageX, y: e.pageY },
      offset: { x: e.pageX - position.left, y: e.pageY - position.top }
    };

    $(window)
      .on("mousemove.drag-ability", this.dragAbilityMove.bind(this))
      .on("mouseup.drag-ability", this.dragAbilityEnd.bind(this));
  }

  dragAbilityMove(e) {
    var dx = e.pageX - this._drag.origin.x;

    e.preventDefault(); // stop dragging from selecting text in input

    if (Math.abs(dx) > 5 && !this._drag.helper) {
      this._drag.helper = this._drag.source.clone().appendTo("body")
        .addClass("dragging")
        .css({
          top: this._drag.origin.y - this._drag.offset.y,
          width: this._drag.source.outerWidth()
        });
    }

    if (this._drag.helper) {
      this._drag.helper.css({ left: e.pageX - this._drag.offset.x });

      this._drag.target = this.form.find(".abilities .base").removeClass("hover").filter(function () {
        var $this = $(this), position = $this.offset();
        return e.pageX >= position.left && e.pageY >= position.top &&
          e.pageX < position.left + $this.outerWidth() &&
          e.pageY < position.top + $this.outerHeight();
      }).addClass("hover");
    }
  }

  dragAbilityEnd(e) {
    if (this._drag.helper) {
      e.preventDefault()

      if (this._drag.target.length) {
        // swap source and target base scores
        var source = this._drag.source, target = this._drag.target,
          a = source.val(), b = target.val();
        source.val(b);
        target.val(a);
        this.fieldChanged();
      }

      this._drag.helper.remove();
    }

    $(window).off(".drag-ability");
    this.form.find(".abilities .base").removeClass("hover");
    delete this._drag;
  }
}

$(function () {
  $(".character-editor").each(function () {
    $(this).data("editor", new Editor(this));
  });
});
