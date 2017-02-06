import http from 'http';
import path from 'path';
import bodyParser from 'body-parser';
import express from 'express';
import 'babel-polyfill';  /* from root packages */ // eslint-disable-line
import { mainStory, chalk } from 'storyboard';
import db from './db';

const PORT = process.env.PORT || 3000;

const createHttpServer = () => {
  const app = express();
  app.use(bodyParser.json());
  app.use(bodyParser.urlencoded({ extended: true }));
  app.use(express.static(path.join(process.cwd(), 'lib/public')));
  app.post('/animals', async (req, res) => {
    const { storyId } = req.body;
    let extraParents;
    if (storyId != null) extraParents = [storyId];
    const story = mainStory.child({
      src: 'httpServer',
      title: `HTTP request ${chalk.green(req.url)}`,
      extraParents,
    });
    try {
      const result = await db.getItems({ story });
      story.debug('httpServer', `HTTP response: ${result.length} animals`,
        { attachInline: result });
      res.json(result);
    } finally {
      story.close();
    }
  });
  const httpServer = http.createServer(app);
  httpServer.listen(PORT);
  mainStory.info('httpServer', `Listening on port ${chalk.cyan.bold(PORT)}...`);

  return httpServer;
};

export default createHttpServer;
