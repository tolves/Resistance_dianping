# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#

data = [
  { city: '广州', restaurants: [{ name: '万年', desc: '烧鹅', dp_link: 'http://www.dianping.com/shop/518591' }, { name: '香港庙街煲仔饭', desc: '煲仔饭', dp_link: 'http://www.dianping.com/shop/98101907' }, { name: '雅苑', desc: 'Top5', dp_link: 'http://www.dianping.com/shop/22196971' }, { name: '朝安', desc: '性价比超级高粤菜', dp_link: 'https://www.dianping.com/search/keyword/4/0_%E6%9C%9D%E5%AE%89%E9%B9%85' }, { name: '兴悦', desc: '便宜版利苑，18块片皮鸭', dp_link: 'https://www.dianping.com/search/keyword/4/0_%E5%85%B4%E6%82%A6' }, { name: '名荟', desc: '烧鹅，金钱展，喝茶', dp_link: 'http://www.dianping.com/shop/518219' }, { name: '南岗章记', desc: '鱼包', dp_link: 'http://www.dianping.com/shop/17583523' }, { name: '联丰美食', desc: '番禺猪杂', dp_link: 'http://www.dianping.com/shop/4539344' }, { name: '奇香楼', desc: '冬瓜盅八宝鸭月饼', dp_link: 'http://www.dianping.com/shop/2806219' }, { name: '顺得来', desc: '脆肉脘', dp_link: 'http://www.dianping.com/shop/45259058' }, { name: '烁臻', desc: '禾杆草', dp_link: 'http://www.dianping.com/shop/59092296' }, { name: '蚝专家', desc: '生蚝', dp_link: 'https://www.dianping.com/search/keyword/4/0_%E8%9A%9D%E4%B8%93%E5%AE%B6' }, { name: '永利', desc: '吃饭，饮茶，不可缺', dp_link: 'http://www.dianping.com/shop/111596488' }, { name: '南雄土菜馆', desc: '辣！', dp_link: 'https://www.dianping.com/search/keyword/4/0_%E5%8D%97%E9%9B%84%E5%9C%9F%E8%8F%9C%E9%A6%86' }, { name: '庆云居', desc: '云吞面', dp_link: 'http://www.dianping.com/shop/90074110' }, { name: '好膳面', desc: '猪肝云吞面', dp_link: '' }, { name: '海晏楼', desc: '白天鹅大厨米其林', dp_link: 'https://www.dianping.com/search/keyword/4/0_%E6%B5%B7%E5%AE%B4%E6%A5%BC' }, { name: '陈记烧腊店', desc: '小吃', dp_link: '' }, { name: '斋烧鹅', desc: '小吃', dp_link: '' }, { name: '细岗水果店炒冰', desc: '小吃', dp_link: 'http://www.dianping.com/shop/68140001' }, { name: '稳健', desc: '小吃', dp_link: 'http://www.dianping.com/shop/124601920' }, { name: '富邦1603咖啡蛋糕', desc: '小吃', dp_link: 'http://www.dianping.com/shop/17638895' }, { name: '荣华楼旁边粽子', desc: '小吃', dp_link: 'http://www.dianping.com/shop/1923391' }, { name: '才记火足肉', desc: '小吃', dp_link: 'http://www.dianping.com/shop/10000498' }, { name: '潮汕豆浆', desc: '小吃', dp_link: 'http://www.dianping.com/shop/130577620' }, { name: '永记', desc: '小吃', dp_link: '' }] },
  { city: '北京',
    restaurants: [
      { name: '常赢三兄弟涮肉(西直门店)', desc: '北下关 老北京火锅', dp_link: 'http://www.dianping.com/shop/k5AzH37TrykE9J8Y' },
      { name: '北京宜宾招待所', desc: '宣武门 川菜馆', dp_link: 'http://www.dianping.com/shop/G9B5lBAWimhGRPnh' },
      { name: '晟永兴烤鸭店(五道口店)', desc: '五道口 烤鸭', dp_link: 'http://www.dianping.com/shop/l3wcFXESWeTrFO75' },
      { name: '松鹤楼面馆(芳草地店)', desc: '东大桥 粉面馆', dp_link: 'http://www.dianping.com/shop/l7ZdOIpDB6depM77' },
      { name: '淮扬菜品鉴赏', desc: '航天桥 淮扬菜', dp_link: 'http://www.dianping.com/shop/EZTvawjaPTqwAkiO' },
      { name: '千牛刀·霸气牛肉锅(东直门店)', desc: '东直门 牛羊肉火锅', dp_link: 'http://www.dianping.com/shop/G89RD0yucUNKuPci' },
      { name: '金斯特餐厅(大钟寺店)', desc: '大钟寺 新疆菜', dp_link: 'http://www.dianping.com/shop/H7OeBKsa1qnreghA' },
      { name: '義公子冰煮羊火锅(五道口店)', desc: '五道口 牛羊肉火锅', dp_link: 'http://www.dianping.com/shop/FQz9gOQcUetIxR2B' },
      { name: '九本しんいち居酒屋(中关村店)', desc: '中关村 日料', dp_link: 'http://www.dianping.com/shop/k78PJoSMC0m1luzN' },
      { name: '静一餐厅·湖北菜(东直门旗舰店)', desc: '东直门 湖北菜', dp_link: 'http://www.dianping.com/shop/iDrSA0KDWZwdUygD' },
      { name: '萃華楼(新世界百货店)', desc: '崇文门 鲁菜', dp_link: 'http://www.dianping.com/shop/HaLpW5Gz2VP7YZ3M' },
      { name: '常德派艺术餐厅', desc: '宋庄 湘菜', dp_link: 'http://www.dianping.com/shop/G5JM2NvjFtf59QlT' },
      { name: '漢舍中国菜馆(万通店)', desc: '世贸天阶 烤鸭', dp_link: 'http://www.dianping.com/shop/k2h7mCqlWOh3gNfm' },
      { name: '情忆草原涮肉馆', desc: '双井 老北京火锅', dp_link: 'http://www.dianping.com/shop/k9dqWjlyoOriJ3jn' },
      { name: '皖南水乡(中关村店)', desc: '中关村 徽菜', dp_link: 'http://www.dianping.com/shop/H2wayznVYqIGOsWJ' },
      { name: '蚝英雄·鲜蚝自助专门店(苏州街店)', desc: '中关村 自助餐', dp_link: 'http://www.dianping.com/shop/laS9O3akAIIE0mD0' },
      { name: '锦府盐帮·李宅(欧美汇购物中心店)', desc: '中关村 川菜', dp_link: 'http://www.dianping.com/shop/H3yZ4sHlrujRKgbC' },
      { name: '泉味道贵州厨房', desc: '西直门 黔菜', dp_link: 'http://www.dianping.com/shop/l34n8GMTEI2wzrlQ' },
      { name: '九十九顶毡房(清河店)', desc: '清河 内蒙菜', dp_link: 'http://www.dianping.com/shop/k445tvHcLlQsum5F' },
      { name: '四季民福烤鸭店(工体店)', desc: '三里屯/工体 烤鸭', dp_link: 'http://www.dianping.com/shop/k17a06RPgHAMZor5' },
      { name: '牛街老爆肚满(朝阳门北小街店)', desc: '东四 老北京小吃', dp_link: 'http://www.dianping.com/shop/laQAoSMKfXad0Upn' },
      { name: '普希金文学餐厅(三里屯店)', desc: '三里屯/工体 俄罗斯菜', dp_link: 'http://www.dianping.com/shop/k8h6MXs9gFMsAIc4' },
      { name: '很久以前羊肉串(双井店)', desc: '双井 烤串', dp_link: 'http://www.dianping.com/shop/l43aqenNZvgR8RyB' },
      { name: '天丼の匠', desc: '双井 日料', dp_link: 'http://www.dianping.com/shop/G4MWAX3qyqOEZ3Xz' },
      { name: '拾久(东三环中路店)', desc: '双井 烤鸭', dp_link: 'http://www.dianping.com/shop/GaLvmTNhT80CWTEO' },
      { name: '湘爱(工体店)', desc: '工体 湘菜', dp_link: 'http://www.dianping.com/shop/laWVO20iHmr8wlEo' },
      { name: '義公子冰煮羊火锅(魏公村店)', desc: '魏公村 牛羊肉火锅', dp_link: 'http://www.dianping.com/shop/l4WXBgA6zKUbrMrh' }
    ]
  },
  {
    city: '上海',
    restaurants: [
      { name: '天虹涮肉(紫藤路店)', desc: '虹桥镇 老北京火锅', dp_link: 'http://www.dianping.com/shop/k5AzH37TrykE9J8Y' },
      { name: '甬府小鲜(万象城店)', desc: '虹桥镇 海鲜', dp_link: '' },
      { name: '喜粤8号(汝南街总店)', desc: '西藏南路 粤菜', dp_link: '' },
      { name: '望蓉城·古法酸菜鱼(环球港店)', desc: '月星环球港 水煮鱼', dp_link: '' },
      { name: '朵馥苑酒家(申亚珺悦18广场店)', desc: '北新泾 本帮', dp_link: '' },
      { name: 'Garlic Barbecue 18小时果木烟熏烤肉', desc: '新天地 拉美烤肉', dp_link: '' },
      { name: '阿翁沙茶面', desc: '和平公园 蓝军餐厅', dp_link: '' },
      { name: 'bluefrog蓝蛙(环球金融中心店)', desc: '陆家嘴 西餐', dp_link: '' },
      { name: 'Polux by Paul Pairet', desc: '新天地 法国菜', dp_link: '' },
      { name: '奎克咖啡Cuiqu(爱琴海购物公园店)', desc: '龙柏 甜品', dp_link: '' },
      { name: '阿文夜市豆浆(北外滩店)', desc: '北外滩 简餐', dp_link: '' },
      { name: '今日牛事潮汕鲜牛肉火锅(徐汇总店)', desc: '漕河泾 潮汕牛肉火锅', dp_link: '' },
      { name: 'FAT PHO大發越南粉(徐家汇店)', desc: '徐家汇 越南菜', dp_link: '' },
      { name: '宁夏印象·盐池滩羊体验店', desc: '长寿路 西北菜', dp_link: '' },
      { name: '大吉(田尚坊店)', desc: '漕河泾 日式烤肉', dp_link: '' },
      { name: '親父的右腕', desc: '中山公园 日料', dp_link: '' },
      { name: 'Popeyes(淮海中路旗舰店)', desc: '淮海路 西式快餐', dp_link: '' },
      { name: 'Bird RYU·鳥龍笑鱼', desc: '世纪大道 日料', dp_link: '' },
      { name: '很久以前羊肉串(南方商城店)', desc: '莲花路 烤串', dp_link: '' },
      { name: '太二酸菜鱼(仲盛世界商城店)', desc: '莘庄 水煮鱼', dp_link: '' },
      { name: '麦麦山云南菜(中庚漫游城店)', desc: '莲花路 滇菜', dp_link: '' },
      { name: '金匠寿司(中庚漫游城店)', desc: '南方商城 寿司', dp_link: '' },
      { name: '蒸汽制造(中庚漫游城店)', desc: '南方商城 海鲜', dp_link: '' },
      { name: 'Grinder绞肉机汉堡(Luone凯德晶萃广场店)', desc: '田子坊 西式快餐', dp_link: '' },
      { name: '西环肥仔螺蛳粉', desc: '田子坊 米粉', dp_link: '' },
      { name: '炙香烤串(水清路店)', desc: '莘庄 烤串', dp_link: '' },
      { name: '塔哈尔(星游城店)', desc: '万体馆 新疆菜', dp_link: '' },
      { name: 'OVERDOSE', desc: '静安寺 日式烤肉', dp_link: '' },
      { name: '鸟啸炭火烧酒场(长乐路店)', desc: '淮海路 日料', dp_link: '' },
      { name: '福烤锦花(荣华东道店)', desc: '古北 日式烧肉', dp_link: '' },
      { name: 'bluefrog蓝蛙(凯德晶萃广场店)', desc: '新天地 西餐', dp_link: '' },
      { name: '屯京拉麵(环球金融中心店)', desc: '陆家嘴 日本拉面', dp_link: '' },
      { name: '南麓·浙里(外滩店)', desc: '外滩 浙菜', dp_link: '' },
      { name: '食光西餐厅Scarpetta', desc: '新天地 意大利菜', dp_link: '' },
      { name: '任兴记(定西路店)', desc: '中山公园 顺德菜', dp_link: '' },
      { name: '杨记齐齐哈尔烤肉(杨浦店)', desc: '平凉路 融合烤肉', dp_link: '' },
      { name: '本甄精品川菜(新天地店)', desc: '新天地 川菜', dp_link: '' },
      { name: '金玉满堂潮州酒楼(无限极荟购物广场店)', desc: '新天地 潮汕菜', dp_link: '' },
      { name: '鮨隐·笑鱼', desc: '人广 日料', dp_link: '' },
      { name: 'PASS RESIDENCE', desc: '淮海路 西餐', dp_link: '' },
      { name: 'Dip In Gelato', desc: '静安寺 冰激凌', dp_link: '' },
      { name: '明阁', desc: '虹桥枢纽 粤菜', dp_link: '' },
      { name: 'Punch 酒吧Punch Room', desc: '南京东路 清吧', dp_link: '' },
      { name: 'そば道·荞麦道日本料理', desc: '古北 日料', dp_link: '' },
      { name: 'AINI BAYI RESTAURANT 艾尼巴億(曲阳路店)', desc: '曲阳 新疆菜', dp_link: '' },
      { name: 'AJIYA(静安店)', desc: '南京西路 日式烧肉', dp_link: '' },
      { name: '龍炎馬仔烧味', desc: '陆家嘴 烧腊', dp_link: '' },
      { name: 'BAR NO·3', desc: '复兴西路 清吧', dp_link: '' },
      { name: '黔上品·酸汤鱼(龙阳广场总店)', desc: '世纪公园 黔菜', dp_link: '' },
      { name: '熠盛粤味', desc: '音乐学院 顺德菜', dp_link: '' },
      { name: '一得仙(崂山路店)', desc: '八佰伴 海鲜', dp_link: '' },
      { name: '懿·EAST(陆家嘴中心店)', desc: '八佰伴 淮扬菜', dp_link: '' },
      { name: 'MERCADO 505 Gourmet Restaurant', desc: '静安寺 西班牙菜', dp_link: '' },
      { name: "L'ATELIER de Joël Robuchon", desc: '外滩 法国菜', dp_link: '' },
      { name: 'Ramen满吉', desc: '人广 西餐', dp_link: '' },
      { name: '小螺莉螺蛳粉(八佰伴店)', desc: '八佰伴 米粉', dp_link: '' },
      { name: '东东砂锅美食', desc: '新天地 简餐', dp_link: '' },
    ]
  },
  {
    city: '佛山',
    restaurants: [
      { name: '君临', desc: '性价比旧式菜', dp_link: 'http://www.dianping.com/shop/574456' },
      { name: '晶品乳鸽', desc: '非法行医鸽', dp_link: 'https://www.dianping.com/search/keyword/208/0_%E6%99%B6%E5%93%81%E4%B9%B3%E9%B8%BD' },
      { name: '大笑农庄', desc: '', dp_link: '' },
      { name: '金榜奶', desc: '', dp_link: 'https://www.dianping.com/search/keyword/208/0_%E9%87%91%E6%A6%9C%E5%A5%B6' },
      { name: '超级物种', desc: '芒果', dp_link: '' },
      { name: '猪肉婆或德', desc: '', dp_link: 'http://www.dianping.com/shop/4107655' },
      { name: '红星', desc: '煲仔饭', dp_link: 'https://www.dianping.com/search/keyword/208/0_%E7%BA%A2%E6%98%9F%20%E7%85%B2%E4%BB%94%E9%A5%AD' }
    ]
  },
  {
    city: '泉州',
    restaurants: [
      { name: '美好生活沙茶面', desc: '印尼沙茶面', dp_link: 'http://www.dianping.com/shop/l7dT1vBaGiKTeTj9' },
      { name: '切意烤羊腿(万达店)', desc: '烤羊腿', dp_link: 'http://www.dianping.com/shop/H484u1h2Tv1eST3g' },
      { name: '里面(南俊店)', desc: '牛肉面', dp_link: 'http://www.dianping.com/shop/k2Y91Owm5NOfwV3c' },
      { name: '和尚牛肉店', desc: '', dp_link: 'http://www.dianping.com/shop/G7dFjVWeLd697BhF' },
      { name: '庄记美食餐馆', desc: '面食', dp_link: 'http://www.dianping.com/shop/k9dOX73AqDtPu0Kx' },
      { name: '好成财牛排馆(涂门街店)', desc: '牛肉', dp_link: 'http://www.dianping.com/shop/k5ioutqHH7xR2SlB' }
    ]
  },
  {
    city: '桂林',
    restaurants: [
      { name: '米粉简介', desc: '有卤菜粉、汤菜粉和牛菜粉，最基础的是卤菜粉，如果不知道点什么先点卤菜粉。粉根据宽扁分为米粉和切粉，米粉是圆长条的，切粉是扁长条的。切菜的阿姨问你要什么的肉的时候，一般会配牛肉和锅烧（锅烧很酥很脆，也是特色配菜，推一下），旁边的桌子上有酸菜辣椒等佐料可以自行添加', dp_link: '' },
      { name: '明桂米粉', desc: '连锁店', dp_link: 'https://www.dianping.com/search/keyword/226/0_%E6%98%8E%E6%A1%82%E7%B1%B3%E7%B2%89' },
      { name: '崇善米粉', desc: '连锁店', dp_link: 'https://www.dianping.com/search/keyword/226/0_%E5%B4%87%E5%96%84%E7%B1%B3%E7%B2%89' },
      { name: '青云汤粉', desc: '汤粉', dp_link: 'https://www.dianping.com/search/keyword/226/0_%E9%9D%92%E4%BA%91%E6%B1%A4%E7%B2%89' },
      { name: '全州红油米粉', desc: '红油米粉是当地一种细粉（比市区的米粉更洗更韧）加上辣得过瘾的红油和瘦肉、黄豆、配汤汁的粉。有机会+能吃辣可以试试~，可能全州的店会更正宗吧，桂林也有几家很好吃的！但是位置不太好找，遇上可以试试。', dp_link: 'https://www.dianping.com/search/keyword/226/0_%E5%85%A8%E5%B7%9E%E7%BA%A2%E6%B2%B9%E7%B1%B3%E7%B2%89' },
      { name: '涵香杀猪佬', desc: '三鲜煮粉和酸辣煮粉，要是能吃辣一定要试试酸辣煮粉。不能吃辣三鲜煮粉也是很鲜的。三鲜是猪肉、猪肝和粉肠，如果不吃粉肠提前和店家就好。两种煮粉的粉也是米粉或切粉，一般二两5.5元起步，6元7元可能都有', dp_link: 'https://www.dianping.com/search/keyword/226/10_%E6%B6%B5%E9%A6%99%E6%9D%80%E7%8C%AA%E4%BD%AC' },
      { name: '王城马肉馆', desc: '马肉米粉', dp_link: 'http://www.dianping.com/shop/k9NdnLXg4C8bMSzO' },
      { name: '牧童(东西巷店)', desc: '改良桂林菜 桂林特色菜', dp_link: 'http://www.dianping.com/shop/H3SQMs8c4afJCOqC' },
      { name: '瑶姑油茶', desc: '炒粉 便宜好吃', dp_link: 'http://www.dianping.com/shop/H9jlGCgqr7MduGdA' },
      { name: '九岗汤粉', desc: '印尼沙茶面', dp_link: 'http://www.dianping.com/shop/k36CA43rLpTL4ha4' }
    ]
  },
  {
    city: '西安',
    restaurants: [
      { name: '老刘家泡馍馆', desc: '泡馍', dp_link: 'http://www.dianping.com/shop/H5Vm3g3g21hL2jeT' },
      { name: '金牌老碗时尚陕菜', desc: '陕菜', dp_link: 'http://www.dianping.com/shop/k4BYue8JLy9UNbSN' },
      { name: '秦豫肉夹馍', desc: '肉夹馍', dp_link: 'http://www.dianping.com/shop/H85BwWyJChePUcpF' },
      { name: '天发芽何记葫芦头泡馍', desc: '泡馍', dp_link: 'http://www.dianping.com/shop/k1w1Zmts4HOmWNF8' },
      { name: '清真·马峰烤肉', desc: '烤肉', dp_link: 'http://www.dianping.com/shop/Ga2jxOgppj8jM9xX' },
      { name: '李志贤灌汤包子', desc: '小吃', dp_link: 'http://www.dianping.com/shop/G26IYKDPL1b3ZpLK' },
      { name: '鐵老十', desc: '泡馍', dp_link: 'http://www.dianping.com/shop/EtGvrlxkNais8FzY' },
      { name: '清真·定家小酥肉', desc: '小酥肉', dp_link: 'http://www.dianping.com/shop/G4LEjkdbJ14GgfyN' },
      { name: '小贾麻花油茶', desc: '小吃', dp_link: 'http://www.dianping.com/shop/HabFndysbQ2RL6de' },
      { name: '刘老虎肉丸糊辣汤', desc: '糊辣汤', dp_link: 'http://www.dianping.com/shop/G4w4O8k6hSIhpfp6' },
      { name: '贾五油糊馅', desc: '小吃', dp_link: 'http://www.dianping.com/shop/G5AtEdLvWt6JOAWy' },
      { name: '回坊马二酸汤水饺', desc: '酸汤水饺', dp_link: 'http://www.dianping.com/shop/k9AxtswbuHVTESqT' },
      { name: '爱骅裤带面馆', desc: '裤带面', dp_link: 'http://www.dianping.com/shop/k4MQcT0ou69m0Ult' },
      { name: '澄城會館', desc: '水盆羊肉', dp_link: 'http://www.dianping.com/shop/G9iSSlKvlPMjEPgA' },
      { name: '东府小杨澄城水盆羊肉', desc: '水盆羊肉', dp_link: 'http://www.dianping.com/shop/l99caphJAPGvuRj5' },
      { name: '澄城吕记水盆羊肉', desc: '水盆羊肉', dp_link: 'http://www.dianping.com/shop/k1D6h50YQVqkxNVE' },
      { name: '清真东南亚甑糕', desc: '小吃', dp_link: 'http://www.dianping.com/shop/Gap5lXMZoWTQNwYU' },
      { name: '何老二卤汁凉粉', desc: '小吃', dp_link: 'http://www.dianping.com/shop/G3R3U7kgpa4XSyt1' },
      { name: '马治钢油糕', desc: '小吃', dp_link: 'http://www.dianping.com/shop/G6UyzgM88ajVVB4J' },
      { name: '彦彬元宵绿豆糕店', desc: '甜品', dp_link: 'http://www.dianping.com/shop/l9sLP5Cenwp5EsWl' },
      { name: '赵老五甜食', desc: '甜品', dp_link: 'http://www.dianping.com/shop/H2kM3oji2KkwYJ0a' },
      { name: '陕拾叁', desc: '小吃', dp_link: 'http://www.dianping.com/shop/l8qbUQaSQNjSLD2i' },
      { name: '三兄弟高炉烧饼', desc: '小吃', dp_link: 'http://www.dianping.com/shop/k93mOsQ2HIcvBQ6i' },
      { name: '惠记粉汤羊血', desc: '小吃', dp_link: 'http://www.dianping.com/shop/l9GFiVaRbHjhi3sF' },
      { name: '王凯老菜馆', desc: '陕菜', dp_link: 'http://www.dianping.com/shop/lafico8JALf0SHal' },
      { name: '马建山口口香粉蒸肉', desc: '粉蒸肉', dp_link: 'http://www.dianping.com/shop/laIs2pK5QsTSJnaw' },
      { name: '清真盛志望麻酱酿皮铺', desc: '酿皮', dp_link: 'http://www.dianping.com/shop/k3clXXglJLCek4Ss' },
      { name: '志亮灌汤蒸饺•清真 ', desc: '灌汤蒸饺', dp_link: 'http://www.dianping.com/shop/G4hWZLRAPkseZNvv' },
      { name: '吴升米皮店', desc: '米皮', dp_link: 'http://www.dianping.com/shop/k6Vo9l5DHCJlluMr' },
      { name: '清真华宇开锅羊肉', desc: '开锅羊肉', dp_link: 'http://www.dianping.com/shop/l35sn6TkagFlDtfC' },
    ]
  },
  {
    city: '昆明',
    restaurants: [
      { name: '云平风味园', desc: '包浆豆腐 罐罐米线', dp_link: 'http://www.dianping.com/shop/k8ZVnnz1gA3AyHVG' },
      { name: '官渡小吃(和平美食城店)', desc: '好吃的真的哭了出来', dp_link: 'http://www.dianping.com/shop/H883H3p6dLvrwIJs' },
      { name: '端仕小锅', desc: '百年老店', dp_link: 'https://www.dianping.com/search/keyword/267/0_%E7%AB%AF%E4%BB%95%E5%B0%8F%E9%94%85' },
    ]
  },
  {
    city: '乐山',
    restaurants: [
      { name: '王浩儿纪六孃', desc: '甜皮鸭', dp_link: 'http://www.dianping.com/shop/l94Sjs8cv4MEdJXd' },
      { name: '叶婆婆钵钵鸡', desc: '冷锅串串', dp_link: 'http://www.dianping.com/shop/H53ErShpvWpFNKAX' },
      { name: '李老三油炸串串香(总店)', desc: '油炸', dp_link: 'http://www.dianping.com/shop/l4MzE1B8G7rfTGn4' },
    ]
  },
  {
    city: '峨眉山',
    restaurants: [
      { name: '搅三搅峨眉名食', desc: '蛋冲豆腐脑 咔饼', dp_link: 'https://www.dianping.com/shop/k84akXGlGF9qXq6e'}
    ]
  },
  {
    city: '徐州',
    restaurants: [
      { name: '两来风', desc: '辣汤', dp_link: 'https://www.dianping.com/search/keyword/92/10_%E4%B8%A4%E6%9D%A5%E9%A3%8E'},
    ]
  }
]
data.each do |d|
  city = City.find_by_name(d[:city])
  d[:restaurants].each do |r|
    city.restaurants.create(name: r[:name], desc: r[:desc], dp_link: r[:dp_link], confirmation: true)
  end
end

Admin.create(chat_id: 75708608)
