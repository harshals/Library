
MainController = function(app) { with (app) {
app.get('#/home', function(context) {

       context.render('views/index.html').replace("#main-content");
});

app.get('#/table', function(context) {

        context.render('views/tables.html').replace("#main-content");
        context.render('views/table-menu.html').replace("#section-menu");
});
app.get('#/form', function(context) {

		context.render('views/form-menu.html').replace("#section-menu");

});
app.get('#/overview', function(context) {

        context.render('views/overview-main.html').replace("#main-content");

		context.render('views/overview-sidebar.html').replace("#sidebar-content");

		context.render('views/overview-extra.html').replace("#content-extra");
});

app.get('#/menu', function(context) {

        context.render('views/menu.html').replace("#section-menu");
});

app.get('#/media', function(context) {

        context.render('views/media-menu.html').replace("#section-menu");
});

}};
