class Editor {
  constructor(form) {
    this.form = $(form);
    this.form.on("input, change", ":input", this.fieldChanged.bind(this));
  }

  fieldChanged(e) {
    this.scheduleCheck();
  }

  scheduleCheck() {
    clearTimeout(this._pendingCheck);
    this._pendingCheck = setTimeout(this.check.bind(this), 500);
  }

  check() {
    var json = this.toJSON();
    $.ajax({
      url: "/characters/check",
      type: "post",
      dataType: "json",
      contentType: "application/json",
      data: JSON.stringify(json)
    }).done(this.processCheckResult.bind(this));
  }

  processCheckResult(data) {
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
      name = input.attr("name");

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
}

$(function () {
  $(".new_character, .edit_character").each(function () {
    $(this).data("editor", new Editor(this));
  });
});
