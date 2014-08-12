module.exports = function(app) {
  app.get('/articles', function(req, res) {
    res.send({
      meta: {uid: 123},
      articles:[
        {
          id: 2,
          title: 'Article two',
          body: 'Body of article two'
        },
        {
          id: 6,
          title: 'Article six',
          body: 'Body of article six'
        },
        {
          id: 9,
          title: 'Article nine',
          body: 'Body of article nine'
        }
      ]
    });
  });
};
