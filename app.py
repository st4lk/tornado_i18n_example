import tornado.ioloop
import tornado.web
from babel.numbers import format_currency


class HomeHandler(tornado.web.RequestHandler):

    def get(self):
        _ = self.locale.translate
        count = int(self.get_argument('count', 1))
        format_usd = lambda p: format_currency(p, currency="USD",
            locale=self.locale.code)
        self.render("home.html", text=_("Hello, world!"), count=count,
            format_usd=format_usd)


application = tornado.web.Application([
    tornado.web.url(r"/", HomeHandler, name='home'),
])


if __name__ == "__main__":
    tornado.locale.load_gettext_translations('locale', 'messages')
    application.listen(8888)
    tornado.ioloop.IOLoop.instance().start()
