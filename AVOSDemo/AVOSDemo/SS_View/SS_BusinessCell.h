#import "SS_BusinessModel.h"
#import "SS_BaseCell.h"

@interface SS_BusinessCell : SS_BaseCell
@property (nonatomic,strong)SS_BusinessModel * businessModel;
@property (weak, nonatomic) IBOutlet UIImageView *logoView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;

+(instancetype)instanceWithXib;
@end
