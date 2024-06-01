using Quiz.Task.Service.Models;
using Quiz.Task.Service.ResponseDtos;

namespace Quiz.Task.Service.Extensions
{
    public static class Extensions
    {
        public static CardDto AsDto(this Card card)
        {
            return new CardDto(card.Id, card.Term, card.Definition);
        }

        public static UserDto AsDto(this UserInfo user)
        {
            return new UserDto(user.Id, user.UserName, user.CreateDate, user.Image);
        }
        public static StudySetDto AsDto(this StudySet studySet)
        {
            return new StudySetDto(studySet.Id, studySet.StudySetName,
             studySet.CreateDate, studySet.User?.AsDto(),
             studySet.Cards?.Select(card => card.AsDto()).ToList());
        }
        public static StudySetBriefDto AsBriefDto(this StudySet studySet)
        {
            return new StudySetBriefDto(studySet.Id, studySet.StudySetName,
             studySet.CreateDate, studySet.User?.AsDto(),
             (int)studySet.Cards?.ToList().Count());
        }
        public static ClassDto AsDto(this Class rs_class)
        {
            int foldersCount = rs_class.Folders != null ? rs_class.Folders.Count : 0;
            int membersCount = rs_class.Members != null ? rs_class.Members.Count : 0;
            return new ClassDto(rs_class.Id, rs_class.ClassName,
             rs_class.CreateDate, rs_class.Description, rs_class.User?.AsDto(),
             foldersCount, membersCount);
        }
        public static MemberDto AsDto(this Member member)
        {
            return new MemberDto(member.Id, member.Class?.AsDto(), member.User?.AsDto());
        }
        public static FolderDto AsDto(this Folder folder)
        {
            return new FolderDto(folder.Id, folder.FolderName,
             folder.CreateDate, folder.User?.AsDto(), folder.Class?.AsDto(),
             folder.FolderDetails?.Select(folderDetail => folderDetail.AsDto()).ToList());
        }
        public static FolderDetailDto AsDto(this FolderDetail folderDetail)
        {
            return new FolderDetailDto(folderDetail.Id, folderDetail.FolderId, folderDetail.StudySetId);
        }
    }
}