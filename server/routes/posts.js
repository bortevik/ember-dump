module.exports = function(app) {
  app.get('/posts', function(req, res) {
    res.send({
      posts:[
        {
          id: 4,
          title: 'Post four',
          body: 'Body of post four'
        },
        {
          id: 5,
          title: 'Post five',
          body: 'Body of post five'
        },
        {
          id: 7,
          title: 'Post seven',
          body: 'Body of post seven'
        }
      ]
    });
  });
};
